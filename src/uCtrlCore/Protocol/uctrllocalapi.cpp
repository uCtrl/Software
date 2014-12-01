#include "uctrllocalapi.h"
#include <QJsonObject>
#include <QJsonDocument>
#include "../Platform/uplatform.h"

UCtrlLocalApi::UCtrlLocalApi(UPlatformsModel* platforms, QObject* parent)
    : QObject(parent)
    , m_multicastAddress("224.1.1.1")
    , m_multicastPort(7)
    , m_platforms(platforms)
    , m_idGenerator(0)
{
    m_socket = new QUdpSocket(this);
    m_socket->bind(m_multicastPort, QUdpSocket::ShareAddress);
    m_socket->joinMulticastGroup(m_multicastAddress);

    connect(m_socket, SIGNAL(readyRead()),
                 this, SLOT(processPendingDatagrams()));
}

void UCtrlLocalApi::processPendingDatagrams()
{
    while (m_socket->hasPendingDatagrams()) {
        QByteArray datagram;
        datagram.resize(m_socket->pendingDatagramSize());
        m_socket->readDatagram(datagram.data(), datagram.size());

        QString multicastData = QString(datagram);
        QJsonObject jsonMulticastObject = QJsonDocument::fromJson(multicastData.toUtf8()).object();

        UEMessageType messageType = (UEMessageType)jsonMulticastObject["messageType"].toInt();

        if (messageType == UEMessageType::GetPlatformResponse)
        {
            QJsonObject jsonPlatformWithoutDevices =
                    jsonMulticastObject["platform"].toArray().first().toObject();
            UPlatform* platform = new UPlatform(m_platforms, true);
            platform->read(jsonPlatformWithoutDevices);

            if (m_platforms->find(platform->id()))
                continue;

            getDevices(platform);
        }
        else
        {
            int messageId = jsonMulticastObject["messageId"].toInt();
            if (!m_messageProperties.contains(messageId))
                continue;

            switch (messageType)
            {
            case UEMessageType::GetDevicesResponse:
            {
                UPlatform* platform = (UPlatform*)m_messageProperties.take(messageId);
                platform->readDevices(jsonMulticastObject);

                if (m_platforms->find(platform->id()) == NULL)
                    m_platforms->appendRow(platform);

                QList<ListItem*> devicesList = platform->nestedModel()->getItems();
                foreach (ListItem* item, devicesList)
                {
                    UDevice* device = (UDevice*)item;
                    getScenarios(device);
                }

                break;
            }
            case UEMessageType::GetScenariosResponse:
            {
                UDevice* device = (UDevice*)m_messageProperties.take(messageId);
                device->readScenarios(jsonMulticastObject);

                QList<ListItem*> scenariosList = device->nestedModel()->getItems();
                foreach (ListItem* item, scenariosList)
                {
                    UScenario* scenario = (UScenario*)item;
                    getTasks(scenario);
                }
                break;
            }
            case UEMessageType::GetTasksResponse:
            {
                UScenario* scenario = (UScenario*)m_messageProperties.take(messageId);
                scenario->readTasks(jsonMulticastObject);

                QList<ListItem*> taskList = scenario->nestedModel()->getItems();
                foreach (ListItem* item, taskList)
                {
                    UTask* task = (UTask*)item;
                    getConditions(task);
                }
                break;
            }
            case UEMessageType::GetConditionsResponse:
            {
                UTask* task = (UTask*)m_messageProperties.take(messageId);
                task->readConditions(jsonMulticastObject);
                break;
            }
            default:
                break;
            }
        }
    }
}

// Returns the list of devices associated to a specified platform
void UCtrlLocalApi::getDevices(UPlatform* platform)
{
    sendGetRequest(platform->ip(),
                   platform->port(),
                   UEMessageType::GetDevicesRequest,
                   "platformId",
                   platform->id(),
                   platform);
}

void UCtrlLocalApi::getScenarios(UDevice* device)
{
    UPlatform* platform = (UPlatform*)device->parent()->parent();
    sendGetRequest(platform->ip(),
                   platform->port(),
                   UEMessageType::GetScenariosRequest,
                   "deviceId",
                   device->id(),
                   device);
}

void UCtrlLocalApi::getTasks(UScenario* scenario)
{
    UPlatform* platform = (UPlatform*)scenario->parent()->parent()->parent()->parent();
    sendGetRequest(platform->ip(),
                   platform->port(),
                   UEMessageType::GetTasksRequest,
                   "scenarioId",
                   scenario->id(),
                   scenario);
}

void UCtrlLocalApi::getConditions(UTask* task)
{
    UPlatform* platform = (UPlatform*)task->parent()->parent()->parent()->parent()->parent()->parent();
    sendGetRequest(platform->ip(),
                   platform->port(),
                   UEMessageType::GetConditionsRequest,
                   "taskId",
                   task->id(),
                   task);
}

void UCtrlLocalApi::sendGetRequest(const QString& address,
                                    int port,
                                    UEMessageType messageType,
                                    const QString& additionalKey,
                                    const QString& additionalValue,
                                    void* property)
{
    QHostAddress hostAddress(address);
    int messageId = nextId();
    QString getRequest = QString("{\"messageType\":%1,\"messageId\":%2,\"%3\":\"%4\"}")
            .arg(QString::number((int)messageType),
                 QString::number(messageId),
                 additionalKey,
                 additionalValue);

    //qDebug() << "Get Request: " << getRequest;

    m_messageProperties.insert(messageId, property);
    m_socket->writeDatagram(getRequest.toUtf8(), hostAddress, port);
}

void UCtrlLocalApi::savePlatform(UPlatform* platform)
{
    QJsonObject jsonPlatform;
    platform->write(jsonPlatform);
    jsonPlatform.remove("devices");

    QJsonArray platformArray;
    platformArray.push_back(QJsonValue(jsonPlatform));

    sendSaveRequest(platform->ip(),
                    platform->port(),
                    UEMessageType::SavePlatformRequest,
                    QString("platform"),
                    platformArray);
}

void UCtrlLocalApi::saveDevice(UDevice* device)
{
    QJsonObject jsonDevice;
    device->write(jsonDevice);
    jsonDevice.remove("scenarios");

    QJsonArray deviceArray;
    deviceArray.push_back(QJsonValue(jsonDevice));

    UPlatform* platform = (UPlatform*)device->parent()->parent();
    saveDevice(platform, deviceArray);
}

void UCtrlLocalApi::saveDevice(UPlatform* platform, const QJsonArray& deviceArray)
{
    sendSaveRequest(platform->ip(),
                    platform->port(),
                    UEMessageType::SaveDeviceRequest,
                    QString("devices"),
                    deviceArray,
                    QString("platformId"),
                    platform->id());
}

void UCtrlLocalApi::saveScenario(UScenario* scenario)
{
    QJsonObject jsonScenario;
    scenario->write(jsonScenario);
    jsonScenario.remove("tasks");

    QJsonArray scenarioArray;
    scenarioArray.push_back(QJsonValue(jsonScenario));

    UDevice* device = (UDevice*)scenario->parent()->parent();
    UPlatform* platform = (UPlatform*)device->parent()->parent();
    saveScenario(platform, device, scenarioArray);
}

void UCtrlLocalApi::saveScenario(UPlatform* platform, UDevice* device, const QJsonArray& scenarioArray)
{
    sendSaveRequest(platform->ip(),
                    platform->port(),
                    UEMessageType::SaveScenarioRequest,
                    QString("scenarios"),
                    scenarioArray,
                    QString("deviceId"),
                    device->id());
}

void UCtrlLocalApi::saveTask(UTask* task)
{
    QJsonObject jsonTask;
    task->write(jsonTask);
    jsonTask.remove("conditions");

    QJsonArray taskArray;
    taskArray.push_back(QJsonValue(jsonTask));

    UScenario* scenario = (UScenario*)task->parent()->parent();
    UPlatform* platform = (UPlatform*)scenario->parent()->parent()->parent()->parent();
    saveTask(platform, scenario, taskArray);
}

void UCtrlLocalApi::saveTask(UPlatform* platform, UScenario* scenario, const QJsonArray& taskArray)
{
    sendSaveRequest(platform->ip(),
                    platform->port(),
                    UEMessageType::SaveTaskRequest,
                    QString("tasks"),
                    taskArray,
                    QString("scenarioId"),
                    scenario->id());
}

void UCtrlLocalApi::saveCondition(UCondition* condition)
{
    QJsonObject jsonCondition;
    condition->write(jsonCondition);

    QJsonArray conditionArray;
    conditionArray.push_back(QJsonValue(jsonCondition));

    UTask* task = (UTask*)condition->parent()->parent();
    UPlatform* platform = (UPlatform*)task->parent()->parent()->parent()->parent()->parent()->parent();
    saveCondition(platform, task, conditionArray);
}

void UCtrlLocalApi::saveCondition(UPlatform* platform, UTask* task, const QJsonArray& conditionArray)
{
    sendSaveRequest(platform->ip(),
                    platform->port(),
                    UEMessageType::SaveConditionRequest,
                    QString("conditions"),
                    conditionArray,
                    QString("taskId"),
                    task->id());
}

void UCtrlLocalApi::sendSaveRequest(const QString& address, int port, UEMessageType messageType, const QString& saveKey, const QJsonArray& jsonArray)
{
    QHostAddress hostAddress(address);
    QJsonDocument jsonDoc(jsonArray);
    QString saveRequest = QString("{\"messageType\":%1,\"size\":%2,\"%3\":%4}")
            .arg(QString::number((int)messageType),
                 QString::number(jsonArray.count()),
                 saveKey,
                 QString(jsonDoc.toJson()));

    //qDebug() << "Save Request: " << saveRequest;

    m_socket->writeDatagram(saveRequest.toUtf8(), hostAddress, port);
}

void UCtrlLocalApi::sendSaveRequest(const QString& address, int port, UEMessageType messageType, const QString& saveKey, const QJsonArray& jsonArray, const QString& additionalKey, const QString& additionalValue)
{
    QHostAddress hostAddress(address);
    QJsonDocument jsonDoc(jsonArray);
    QString saveRequest = QString("{\"messageType\":%1,\"size\":%2,\"%3\":\"%4\",\"%5\":%6}")
            .arg(QString::number((int)messageType),
                 QString::number(jsonArray.count()),
                 additionalKey,
                 additionalValue,
                 saveKey,
                 QString(jsonDoc.toJson()));

    //qDebug() << "Save Request: " << saveRequest;

    m_socket->writeDatagram(saveRequest.toUtf8(), hostAddress, port);
}

void UCtrlLocalApi::deleteDevice(UDevice* device)
{
    UPlatform* platform = (UPlatform*)device->parent()->parent();
    deleteDevice(platform, device);
}

void UCtrlLocalApi::deleteDevice(UPlatform* platform, UDevice* device)
{
    sendDeleteRequest(  platform->ip(),
                        platform->port(),
                        UEMessageType::DeleteDeviceRequest,
                        QString("deviceId"),
                        device->id());
}

void UCtrlLocalApi::deleteScenario(UScenario* scenario)
{
    UPlatform* platform = (UPlatform*)scenario->parent()->parent()->parent()->parent();
    deleteScenario(platform, scenario);
}

void UCtrlLocalApi::deleteScenario(UPlatform* platform, UScenario* scenario)
{
    sendDeleteRequest(  platform->ip(),
                        platform->port(),
                        UEMessageType::DeleteScenarioRequest,
                        QString("scenarioId"),
                        scenario->id());
}

void UCtrlLocalApi::deleteTask(UTask* task)
{
    UPlatform* platform = (UPlatform*)task->parent()->parent()->parent()->parent()->parent()->parent();
    deleteTask(platform, task);
}

void UCtrlLocalApi::deleteTask(UPlatform* platform, UTask* task)
{
    sendDeleteRequest(  platform->ip(),
                        platform->port(),
                        UEMessageType::DeleteTaskRequest,
                        QString("taskId"),
                        task->id());
}

void UCtrlLocalApi::deleteCondition(UCondition* condition)
{
    UPlatform* platform = (UPlatform*)condition->parent()->parent()->parent()->parent()->parent()->parent()->parent()->parent();
    deleteCondition(platform, condition);
}

void UCtrlLocalApi::deleteCondition(UPlatform* platform, UCondition* condition)
{
    sendDeleteRequest(  platform->ip(),
                        platform->port(),
                        UEMessageType::DeleteConditionRequest,
                        QString("conditionId"),
                        condition->id());
}

void UCtrlLocalApi::sendDeleteRequest(const QString& address, int port, UEMessageType messageType, const QString& idKey, const QString& idValue)
{
    QHostAddress hostAddress(address);
    QString deleteRequest = QString("{\"messageType\":%1,\"%2\":\"%3\"}")
            .arg(QString::number((int)messageType),
                 idKey,
                 idValue);

    //qDebug() << "Delete Request: " << deleteRequest;

    m_socket->writeDatagram(deleteRequest.toUtf8(), hostAddress, port);
}
