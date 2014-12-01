#include "uctrlwebsocket.h"

UCtrlWebSocket::UCtrlWebSocket(UPlatformsModel *platforms, const QString &userToken, QObject *parent) :
    QObject(parent), m_platforms(platforms), m_userToken(userToken)
{
    connect(&m_webSocket, SIGNAL(error(QAbstractSocket::SocketError)), this, SLOT(onError(QAbstractSocket::SocketError)));
    connect(&m_webSocket, SIGNAL(connected()), this, SLOT(onConnected()));
    connect(&m_webSocket, SIGNAL(textMessageReceived(QString)), this, SLOT(onMessageReceived(QString)));
    connect(&m_webSocket, SIGNAL(disconnected()), this, SLOT(onClosed()));
}

UCtrlWebSocket::~UCtrlWebSocket()
{
    m_platforms = NULL;
    m_webSocket.close();
    m_webSocket.deleteLater();
}

void UCtrlWebSocket::open(QUrl url)
{
    url.setScheme("ws");
    m_webSocket.open(url);
}

void UCtrlWebSocket::onConnected()
{
    QJsonObject tokenObj;
    tokenObj["token"] = m_userToken;
    QJsonDocument doc(tokenObj);

    m_webSocket.sendTextMessage(QString(doc.toJson()));
}

void UCtrlWebSocket::onError(QAbstractSocket::SocketError error)
{
    emit websocketError("Websocket error (" + QString::number((int)error) + ")");
}

void UCtrlWebSocket::onMessageReceived(const QString &message)
{
    qDebug() << message;

    QJsonObject jsonObj = QJsonDocument::fromJson(message.toUtf8()).object();

    if (jsonObj.empty()) return;

    UCtrlWebSocket::UETarget target = (UCtrlWebSocket::UETarget)jsonObj["target"].toInt();

    switch (target) {
    case UCtrlWebSocket::UETarget::Platform:
        treatPlatform(jsonObj);
        break;
    case UCtrlWebSocket::UETarget::Device:
        treatDevice(jsonObj);
        break;
    case UCtrlWebSocket::UETarget::Scenario:
        treatScenario(jsonObj);
        break;
    case UCtrlWebSocket::UETarget::Task:
        treatTask(jsonObj);
        break;
    case UCtrlWebSocket::UETarget::Condition:
        treatCondition(jsonObj);
        break;
    }
}

void UCtrlWebSocket::onClosed()
{
    emit websocketError("Websocket disconnected");
}

void UCtrlWebSocket::treatPlatform(const QJsonObject &jsonObj)
{
    UCtrlWebSocket::UEAction action = (UCtrlWebSocket::UEAction)jsonObj["action"].toInt();
    QString platformId = jsonObj["platformId"].toString();

    switch (action) {
    case UCtrlWebSocket::UEAction::Create: {
        UPlatform* platform = new UPlatform(m_platforms, false);
        platform->read(jsonObj["item"].toObject());
        m_platforms->appendRow(platform);
        break;
    }
    case UCtrlWebSocket::UEAction::Update: {
        ListItem* platform = m_platforms->find(platformId);
        if (!platform) return;
        platform->read(jsonObj["item"].toObject());
        break;
    }
    case UCtrlWebSocket::UEAction::Delete: {
        m_platforms->removeRow(platformId);
        break;
    }
    }
}

void UCtrlWebSocket::treatDevice(const QJsonObject &jsonObj)
{
    UCtrlWebSocket::UEAction action = (UCtrlWebSocket::UEAction)jsonObj["action"].toInt();
    QString platformId = jsonObj["platformId"].toString();
    QString deviceId = jsonObj["deviceId"].toString();

    UPlatform* platform = (UPlatform*)m_platforms->find(platformId);
    if (!platform)
        return;

    UDevicesModel* devices = (UDevicesModel*)platform->nestedModel();

    switch (action) {
    case UCtrlWebSocket::UEAction::Create: {
        UDevice* device = new UDevice(devices);
        device->read(jsonObj["item"].toObject());
        devices->appendRow(device);
        break;
    }
    case UCtrlWebSocket::UEAction::Update: {
        ListItem* device = devices->find(deviceId);
        if (!device) return;
        device->read(jsonObj["item"].toObject());
        break;
    }
    case UCtrlWebSocket::UEAction::Delete: {
        devices->removeRow(deviceId);
        break;
    }
    }
}

void UCtrlWebSocket::treatScenario(const QJsonObject &jsonObj)
{
    UCtrlWebSocket::UEAction action = (UCtrlWebSocket::UEAction)jsonObj["action"].toInt();
    QString platformId = jsonObj["platformId"].toString();
    QString deviceId = jsonObj["deviceId"].toString();
    QString scenarioId = jsonObj["scenarioId"].toString();

    UPlatform* platform = (UPlatform*)m_platforms->find(platformId);
    if (!platform)
        return;

    UDevicesModel* devices = (UDevicesModel*)platform->nestedModel();
    UDevice* device = (UDevice*)devices->find(deviceId);
    if (!device)
        return;

    UScenariosModel* scenarios = (UScenariosModel*)device->nestedModel();

    switch (action) {
    case UCtrlWebSocket::UEAction::Create: {
        UScenario* scenario = new UScenario(scenarios);
        scenario->read(jsonObj["item"].toObject());
        scenarios->appendRow(scenario);
        break;
    }
    case UCtrlWebSocket::UEAction::Update: {
        ListItem* scenario = scenarios->find(scenarioId);
        if (!scenario) return;
        scenario->read(jsonObj["item"].toObject());
        break;
    }
    case UCtrlWebSocket::UEAction::Delete: {
        scenarios->removeRow(scenarioId);
        break;
    }
    }
}

void UCtrlWebSocket::treatTask(const QJsonObject &jsonObj)
{
    UCtrlWebSocket::UEAction action = (UCtrlWebSocket::UEAction)jsonObj["action"].toInt();
    QString platformId = jsonObj["platformId"].toString();
    QString deviceId = jsonObj["deviceId"].toString();
    QString scenarioId = jsonObj["scenarioId"].toString();
    QString taskId = jsonObj["taskId"].toString();

    UPlatform* platform = (UPlatform*)m_platforms->find(platformId);
    if (!platform)
        return;

    UDevicesModel* devices = (UDevicesModel*)platform->nestedModel();
    UDevice* device = (UDevice*)devices->find(deviceId);
    if (!device)
        return;

    UScenariosModel* scenarios = (UScenariosModel*)device->nestedModel();
    UScenario* scenario = (UScenario*)scenarios->find(scenarioId);
    if (!scenario)
        return;

    UTasksModel* tasks = (UTasksModel*)scenario->nestedModel();

    switch (action) {
    case UCtrlWebSocket::UEAction::Create: {
        UTask* task = new UTask(tasks);
        task->read(jsonObj["item"].toObject());
        tasks->appendRow(task);
        break;
    }
    case UCtrlWebSocket::UEAction::Update: {
        ListItem* task = tasks->find(taskId);
        if (!task) return;
        task->read(jsonObj["item"].toObject());
        break;
    }
    case UCtrlWebSocket::UEAction::Delete: {
        tasks->removeRow(taskId);
        break;
    }
    }
}

void UCtrlWebSocket::treatCondition(const QJsonObject &jsonObj)
{
    UCtrlWebSocket::UEAction action = (UCtrlWebSocket::UEAction)jsonObj["action"].toInt();
    QString platformId = jsonObj["platformId"].toString();
    QString deviceId = jsonObj["deviceId"].toString();
    QString scenarioId = jsonObj["scenarioId"].toString();
    QString taskId = jsonObj["taskId"].toString();
    QString conditionId = jsonObj["conditionId"].toString();

    UPlatform* platform = (UPlatform*)m_platforms->find(platformId);
    if (!platform)
        return;

    UDevicesModel* devices = (UDevicesModel*)platform->nestedModel();
    UDevice* device = (UDevice*)devices->find(deviceId);
    if (!device)
        return;

    UScenariosModel* scenarios = (UScenariosModel*)device->nestedModel();
    UScenario* scenario = (UScenario*)scenarios->find(scenarioId);
    if (!scenario)
        return;

    UTasksModel* tasks = (UTasksModel*)scenario->nestedModel();
    UTask* task = (UTask*)tasks->find(taskId);
    if (!task)
        return;

    UConditionsModel* conditions = (UConditionsModel*)task->nestedModel();

    switch (action) {
    case UCtrlWebSocket::UEAction::Create: {
        UCondition* condition = new UCondition(conditions);
        condition->read(jsonObj["item"].toObject());
        conditions->appendRow(condition);
        break;
    }
    case UCtrlWebSocket::UEAction::Update: {
        ListItem* condition = conditions->find(conditionId);
        if (!condition) return;
        condition->read(jsonObj["item"].toObject());
        break;
    }
    case UCtrlWebSocket::UEAction::Delete: {
        conditions->removeRow(conditionId);
        break;
    }
    }
}

