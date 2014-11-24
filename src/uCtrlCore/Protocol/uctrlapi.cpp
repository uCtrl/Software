#include "uctrlapi.h"

UCtrlAPI::UCtrlAPI(QNetworkAccessManager* nam, UPlatformsModel* platforms, QObject *parent) :
    QObject(parent), m_networkAccessManager(nam)
{
    m_platforms = platforms;
    m_serverBaseUrl = "http://uctrl.gel.usherbrooke.ca/dev/"; //"http://uctrl.gel.usherbrooke.ca/dev/";
    m_ninjaToken = "107f6f460bed2dbb10f0a93b994deea7fe07dad5";
}

// /////////////////////////////////////
//              User                  //
// /////////////////////////////////////

// Post user tokens to the server
void UCtrlAPI::postUser()
{
    QJsonObject userObj;
    QJsonObject ninjaObj;
    ninjaObj["userAccessToken"] = m_ninjaToken;
    userObj["ninjablocks"] = ninjaObj;
    QJsonDocument doc(userObj);

    QUrl url(m_serverBaseUrl + "users");
    QNetworkRequest req(url);
    req.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    QNetworkReply* reply = m_networkAccessManager->post(req, doc.toJson(QJsonDocument::Indented));
    connect(reply, SIGNAL(finished()), this, SLOT(postUserReply()));
}

void UCtrlAPI::postUserReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (!checkNetworkError(reply)) {
        reply->deleteLater();
        return;
    }

    QJsonObject jsonObj = QJsonDocument::fromJson(reply->readAll()).object();

    m_userToken = jsonObj["token"].toString();

    // Get all the system
    getSystem();

    // Start the stream
    getUserStream();

    reply->deleteLater();
}

void UCtrlAPI::getUserStream()
{
    connect(&m_webSocket, SIGNAL(connected()), this, SLOT(onConnected()));
    connect(&m_webSocket, SIGNAL(disconnected()), this, SLOT(onClosed()));

    QUrl url(m_serverBaseUrl + "stream");
    url.setScheme("ws");
    m_webSocket.open(url);
}

// /////////////////////////////////////
//             System                 //
// /////////////////////////////////////

// Receive everything
void UCtrlAPI::getSystem()
{
    QNetworkReply* reply = getRequest("system");
    connect(reply, SIGNAL(finished()), this, SLOT(getSystemReply()));
}

void UCtrlAPI::getSystemReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (!checkNetworkError(reply)) {
        reply->deleteLater();
        return;
    }

    QJsonObject jsonObj = QJsonDocument::fromJson(reply->readAll()).object();
    if (!checkServerError(jsonObj)) {
        reply->deleteLater();
        return;
    }

    m_platforms->read(jsonObj);
    reply->deleteLater();
}

// /////////////////////////////////////
//            Platforms               //
// /////////////////////////////////////

// Fetch all claimed platforms
void UCtrlAPI::getPlatforms()
{
    QNetworkReply* reply = getRequest("platforms");
    connect(reply, SIGNAL(finished()), this, SLOT(getPlatformsReply()));
}

void UCtrlAPI::getPlatformsReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (!checkNetworkError(reply)) {
        reply->deleteLater();
        return;
    }

    QJsonObject jsonObj = QJsonDocument::fromJson(reply->readAll()).object();
    if (!checkServerError(jsonObj)) {
        reply->deleteLater();
        return;
    }

    m_platforms->read(jsonObj);
    reply->deleteLater();
}

// Attempt to claim an unclaimed block.
void UCtrlAPI::postPlatform(const QString& platformId)
{
    QNetworkReply* reply = postRequest("platforms",  m_platforms->find(platformId));
    connect(reply, SIGNAL(finished()), this, SLOT(postPlatformsReply()));
}

void UCtrlAPI::postPlatformReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());

    if (!checkNetworkError(reply)) {
        checkServerError(QJsonDocument::fromJson(reply->readAll()).object());
    }
    reply->deleteLater();
}

// Returns data about the specified block.
void UCtrlAPI::getPlatform(const QString& platformId)
{
    QNetworkReply* reply = getRequest(QString("platforms/%1").arg(platformId));
    reply->setProperty(PlatformId, platformId);
    connect(reply, SIGNAL(finished()), this, SLOT(getPlatformReply()));
}

void UCtrlAPI::getPlatformReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (!checkNetworkError(reply)) {
        reply->deleteLater();
        return;
    }

    QJsonObject jsonObj = QJsonDocument::fromJson(reply->readAll()).object();
    if (!checkServerError(jsonObj)) {
        reply->deleteLater();
        return;
    }

    QString platformId = reply->property(PlatformId).toString();
    ListItem* platform = m_platforms->find(platformId);
    if (!checkModel(platform)) {
        reply->deleteLater();
        return;
    }

    platform->read(jsonObj["platform"].toObject());

    reply->deleteLater();
}

void UCtrlAPI::putPlatform(const QString& platformId)
{
    QNetworkReply* reply = putRequest(QString("platforms/%1").arg(platformId), m_platforms->find(platformId));
    connect(reply, SIGNAL(finished()), this, SLOT(putPlatformReply()));
}

void UCtrlAPI::putPlatformReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());

    if (!checkNetworkError(reply)) {
        checkServerError(QJsonDocument::fromJson(reply->readAll()).object());
    }

    reply->deleteLater();
}

// Unpair a block.
void UCtrlAPI::deletePlatform(const QString& platformId)
{
    QNetworkReply* reply = deleteRequest(QString("platforms/%1").arg(platformId));
    connect(reply, SIGNAL(finished()), this, SLOT(deletePlatformReply()));
}

void UCtrlAPI::deletePlatformReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());

    if (!checkNetworkError(reply)) {
        checkServerError(QJsonDocument::fromJson(reply->readAll()).object());
    }

    reply->deleteLater();
}

// /////////////////////////////////////
//             Devices                //
// /////////////////////////////////////

// Returns the list of devices associated to a specified platform
void UCtrlAPI::getDevices(const QString& platformId)
{
    QNetworkReply* reply = getRequest(QString("platforms/%1/devices").arg(platformId));
    reply->setProperty(PlatformId, platformId);
    connect(reply, SIGNAL(finished()), this, SLOT(getDevicesReply()));
}

void UCtrlAPI::getDevicesReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (!checkNetworkError(reply)) {
        reply->deleteLater();
        return;
    }

    QJsonObject jsonObj = QJsonDocument::fromJson(reply->readAll()).object();
    if (!checkServerError(jsonObj)) {
        reply->deleteLater();
        return;
    }

    QString platformId = reply->property(PlatformId).toString();
    NestedListItem* platform = (NestedListItem*)m_platforms->find(platformId);
    if (!checkModel(platform)) {
        reply->deleteLater();
        return;
    }

    platform->nestedModel()->read(jsonObj);

    reply->deleteLater();
}

void UCtrlAPI::postDevice(const QString& platformId, const QString& deviceId)
{
    NestedListItem* platform = (NestedListItem*)m_platforms->find(platformId);
    if (!checkModel(platform))
        return;

    ListItem* device = platform->nestedModel()->find(deviceId);
    if (!checkModel(device))
        return;

    QNetworkReply* reply = postRequest(QString("platforms/%1/devices").arg(platformId), device);
    reply->setProperty(DevicePtr, (long long)device);
    connect(reply, SIGNAL(finished()), this, SLOT(postDeviceReply()));
}

void UCtrlAPI::postDeviceReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());

    QJsonObject jsonDeviceReply = QJsonDocument::fromJson(reply->readAll()).object();
    if (!checkNetworkError(reply)) {
        checkServerError(jsonDeviceReply);
    }

    UDevice* device = (UDevice*)reply->property(DevicePtr).toLongLong();
    device->read(jsonDeviceReply["device"].toObject());

    reply->deleteLater();
}

// Fetch data about the specified device.
void UCtrlAPI::getDevice(const QString& platformId, const QString& deviceId)
{
    QNetworkReply* reply = getRequest(QString("platforms/%1/devices/%2").arg(platformId, deviceId));
    reply->setProperty(PlatformId, platformId);
    reply->setProperty(DeviceId, deviceId);
    connect(reply, SIGNAL(finished()), this, SLOT(getDeviceReply()));
}

void UCtrlAPI::getDeviceReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (!checkNetworkError(reply)) {
        reply->deleteLater();
        return;
    }

    QJsonObject jsonObj = QJsonDocument::fromJson(reply->readAll()).object();
    if (!checkServerError(jsonObj)) {
        reply->deleteLater();
        return;
    }

    QString platformId = reply->property(PlatformId).toString();
    QString deviceId = reply->property(DeviceId).toString();
    NestedListItem* platform = (NestedListItem*)m_platforms->find(platformId);
    if (!checkModel(platform)) {
        reply->deleteLater();
        return;
    }

    ListItem* device = platform->nestedModel()->find(deviceId);
    if (!checkModel(device)) {
        reply->deleteLater();
        return;
    }

    device->read(jsonObj["device"].toObject());

    reply->deleteLater();
}

// Update a device, including sending a command.
void UCtrlAPI::putDevice(const QString& platformId, const QString& deviceId)
{
    NestedListItem* platform = (NestedListItem*)m_platforms->find(platformId);
    if (!checkModel(platform))
        return;

    ListItem* device = platform->nestedModel()->find(deviceId);
    if (!checkModel(device))
        return;

    QNetworkReply* reply = putRequest(QString("platforms/%1/device/%2").arg(platformId, deviceId), device);
    connect(reply, SIGNAL(finished()), this, SLOT(putDeviceReply()));
}

void UCtrlAPI::putDeviceReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());

    if (!checkNetworkError(reply)) {
        checkServerError(QJsonDocument::fromJson(reply->readAll()).object());
    }

    reply->deleteLater();
}

// Delete this device from the system.
void UCtrlAPI::deleteDevice(const QString& platformId, const QString& deviceId)
{
    QNetworkReply* reply = deleteRequest(QString("platforms/%1/device/%2").arg(platformId, deviceId));
    connect(reply, SIGNAL(finished()), this, SLOT(deleteDeviceReply()));
}

void UCtrlAPI::deleteDeviceReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());

    if (!checkNetworkError(reply)) {
        checkServerError(QJsonDocument::fromJson(reply->readAll()).object());
    }

    reply->deleteLater();
}

void UCtrlAPI::getDeviceStats(const QString &platformId, const QString &deviceId, QMap<QString, QVariant> params)
{
    QNetworkReply* reply = getRequest(QString("platforms/%1/devices/%2/stats").arg(platformId, deviceId), params);
    reply->setProperty(PlatformId, platformId);
    reply->setProperty(DeviceId, deviceId);
    connect(reply, SIGNAL(finished()), this, SLOT(getDeviceStatsReply()));
}

void UCtrlAPI::getDeviceStatsReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (!checkNetworkError(reply)) {
        reply->deleteLater();
        return;
    }

    QJsonObject jsonObj = QJsonDocument::fromJson(reply->readAll()).object();
    if (!checkServerError(jsonObj)) {
        reply->deleteLater();
        return;
    }

    QString platformId = reply->property(PlatformId).toString();
    QString deviceId = reply->property(DeviceId).toString();
    NestedListItem* platform = (NestedListItem*)m_platforms->find(platformId);
    if (!checkModel(platform)) {
        reply->deleteLater();
        return;
    }

    UDevice* device = (UDevice*)platform->nestedModel()->find(deviceId);
    if (!checkModel(device)) {
        reply->deleteLater();
        return;
    }

    device->statistics()->read(jsonObj);

    reply->deleteLater();
}

// /////////////////////////////////////
//             Scenario               //
// /////////////////////////////////////

// Fetch all the existing scenarii about a specified device
void UCtrlAPI::getScenarios(const QString& platformId, const QString& deviceId)
{
    QNetworkReply* reply = getRequest(QString("platforms/%1/devices/%2/scenarios").arg(platformId, deviceId));
    reply->setProperty(PlatformId, platformId);
    reply->setProperty(DeviceId, deviceId);
    connect(reply, SIGNAL(finished()), this, SLOT(getScenariosReply()));
}

void UCtrlAPI::getScenariosReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (!checkNetworkError(reply)) {
        reply->deleteLater();
        return;
    }

    QString platformId = reply->property(PlatformId).toString();
    QString deviceId = reply->property(DeviceId).toString();

    QJsonObject jsonObj = QJsonDocument::fromJson(reply->readAll()).object();
    if (!checkServerError(jsonObj)) {
        reply->deleteLater();
        return;
    }

    NestedListItem* platform = (NestedListItem*)m_platforms->find(platformId);
    if (!checkModel(platform)) {
        reply->deleteLater();
        return;
    }

    NestedListItem* device = (NestedListItem*)platform->nestedModel()->find(deviceId);
    if (!checkModel(device)) {
        reply->deleteLater();
        return;
    }

    device->nestedModel()->read(jsonObj);
    reply->deleteLater();
}

// Create a new scenario for specified device
void UCtrlAPI::postScenario(const QString& platformId, const QString& deviceId, const QString& scenarioId)
{
    NestedListItem* platform = (NestedListItem*)m_platforms->find(platformId);
    if (!checkModel(platform))
        return;

    NestedListItem* device = (NestedListItem*)platform->nestedModel()->find(deviceId);
    if (!checkModel(device))
        return;

    ListItem* scenario = device->nestedModel()->find(scenarioId);
    if (!checkModel(scenario))
        return;

    QNetworkReply* reply = postRequest(QString("platforms/%1/devices/%2/scenarios").arg(platformId, deviceId), scenario);
    reply->setProperty(ScenarioPtr, (long long)scenario);
    connect(reply, SIGNAL(finished()), this, SLOT(postScenarioReply()));
}

void UCtrlAPI::postScenarioReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());

    QJsonObject jsonScenarioReply = QJsonDocument::fromJson(reply->readAll()).object();
    if (!checkNetworkError(reply)) {
        checkServerError(QJsonDocument::fromJson(reply->readAll()).object());
    }

    UScenario* scenario = (UScenario*)reply->property(ScenarioPtr).toLongLong();
    scenario->read(jsonScenarioReply["scenario"].toObject());

    reply->deleteLater();
}

// Fetch data about a specified scenario for a specified device
void UCtrlAPI::getScenario(const QString& platformId, const QString& deviceId, const QString& scenarioId)
{
    QNetworkReply* reply = getRequest(QString("platforms/%1/devices/%2/scenarios/%3").arg(platformId, deviceId, scenarioId));
    reply->setProperty(PlatformId, platformId);
    reply->setProperty(DeviceId, deviceId);
    reply->setProperty(ScenarioId, scenarioId);
    connect(reply, SIGNAL(finished()), this, SLOT(getScenarioReply()));
}

void UCtrlAPI::getScenarioReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (!checkNetworkError(reply)) {
        reply->deleteLater();
        return;
    }

    QJsonObject jsonObj = QJsonDocument::fromJson(reply->readAll()).object();
    if (!checkServerError(jsonObj)) {
        reply->deleteLater();
        return;
    }

    QString platformId = reply->property(PlatformId).toString();
    QString deviceId = reply->property(DeviceId).toString();
    QString scenarioId = reply->property(ScenarioId).toString();

    NestedListItem* platform = (NestedListItem*)m_platforms->find(platformId);
    if (!checkModel(platform)) {
        reply->deleteLater();
        return;
    }

    NestedListItem* device = (NestedListItem*)platform->nestedModel()->find(deviceId);
    if (!checkModel(device)) {
        reply->deleteLater();
        return;
    }

    ListItem* scenario = device->nestedModel()->find(scenarioId);
    if (!checkModel(scenario)) {
        reply->deleteLater();
        return;
    }

    scenario->read(jsonObj);

    reply->deleteLater();
}

// Update a specified scenario
void UCtrlAPI::putScenario(const QString& platformId, const QString& deviceId, const QString& scenarioId)
{
    NestedListItem* platform = (NestedListItem*)m_platforms->find(platformId);
    if (!checkModel(platform))
        return;

    NestedListItem* device = (NestedListItem*)platform->nestedModel()->find(deviceId);
    if (!checkModel(device))
        return;

    NestedListItem* scenario = (NestedListItem*)device->nestedModel()->find(scenarioId);
    if (!checkModel(scenario))
        return;

    QNetworkReply* reply = putRequest(QString("platforms/%1/devices/%2/scenarios/%3").arg(platformId, deviceId, scenarioId), scenario);
    connect(reply, SIGNAL(finished()), this, SLOT(putScenarioReply()));
}

void UCtrlAPI::putScenarioReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());

    if (!checkNetworkError(reply)) {
        checkServerError(QJsonDocument::fromJson(reply->readAll()).object());
    }

    reply->deleteLater();
}

// Delete a specified scenario
void UCtrlAPI::deleteScenario(const QString& platformId, const QString& deviceId, const QString& scenarioId)
{
    QNetworkReply* reply = deleteRequest(QString("platforms/%1/devices/%2/scenarios/%3").arg(platformId, deviceId, scenarioId));
    connect(reply, SIGNAL(finished()), this, SLOT(deleteScenarioReply()));
}

void UCtrlAPI::deleteScenarioReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());

    if (!checkNetworkError(reply)) {
        checkServerError(QJsonDocument::fromJson(reply->readAll()).object());
    }

    reply->deleteLater();
}

// /////////////////////////////////////
//               Task                 //
// /////////////////////////////////////

// Fetch all of a scenario's tasks.
void UCtrlAPI::getTasks(const QString& platformId, const QString& deviceId, const QString& scenarioId)
{
    QNetworkReply* reply = getRequest(QString("platforms/%1/devices/%2/scenarios/%3/tasks").arg(platformId, deviceId, scenarioId));
    reply->setProperty(PlatformId, platformId);
    reply->setProperty(DeviceId, deviceId);
    reply->setProperty(ScenarioId, scenarioId);
    connect(reply, SIGNAL(finished()), this, SLOT(getTasksReply()));
}

void UCtrlAPI::getTasksReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (!checkNetworkError(reply)) {
        reply->deleteLater();
        return;
    }

    QString platformId = reply->property(PlatformId).toString();
    QString deviceId = reply->property(DeviceId).toString();
    QString scenarioId = reply->property(ScenarioId).toString();

    QJsonObject jsonObj = QJsonDocument::fromJson(reply->readAll()).object();
    if (!checkServerError(jsonObj)) {
        reply->deleteLater();
        return;
    }

    NestedListItem* platform = (NestedListItem*)m_platforms->find(platformId);
    if (!checkModel(platform)) {
        reply->deleteLater();
        return;
    }

    NestedListItem* device = (NestedListItem*)platform->nestedModel()->find(deviceId);
    if (!checkModel(device)) {
        reply->deleteLater();
        return;
    }

    NestedListItem* scenario = (NestedListItem*)device->nestedModel()->find(scenarioId);
    if (!checkModel(scenario)) {
        reply->deleteLater();
        return;
    }

    scenario->nestedModel()->read(jsonObj);

    reply->deleteLater();
}

// Create a new tasks
void UCtrlAPI::postTask(const QString& platformId, const QString& deviceId, const QString& scenarioId, const QString& taskId)
{
    NestedListItem* platform = (NestedListItem*)m_platforms->find(platformId);
    if (!checkModel(platform))
        return;

    NestedListItem* device = (NestedListItem*)platform->nestedModel()->find(deviceId);
    if (!checkModel(device))
        return;

    NestedListItem* scenario = (NestedListItem*)device->nestedModel()->find(scenarioId);
    if (!checkModel(scenario))
        return;

    ListItem* task = scenario->nestedModel()->find(taskId);
    if (!checkModel(task))
        return;

    QNetworkReply* reply = postRequest(QString("platforms/%1/devices/%2/scenarios/%3/tasks").arg(platformId, deviceId, scenarioId), task);
    reply->setProperty(TaskPtr, (long long)task);
    connect(reply, SIGNAL(finished()), this, SLOT(postTasksReply()));
}

void UCtrlAPI::postTaskReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());

    QJsonObject jsonTaskReply = QJsonDocument::fromJson(reply->readAll()).object();
    if (!checkNetworkError(reply)) {
        checkServerError(jsonTaskReply);
    }

    UTask* task = (UTask*)reply->property(TaskPtr).toLongLong();
    task->read(jsonTaskReply["task"].toObject());

    reply->deleteLater();
}

// Fetch data about a specified task
void UCtrlAPI::getTask(const QString& platformId, const QString& deviceId, const QString& scenarioId, const QString& taskId)
{
    QNetworkReply* reply = getRequest(QString("platforms/%1/devices/%2/scenarios/%3/tasks/%4").arg(platformId, deviceId, scenarioId, taskId));
    reply->setProperty(PlatformId, platformId);
    reply->setProperty(DeviceId, deviceId);
    reply->setProperty(ScenarioId, scenarioId);
    reply->setProperty(TaskId, taskId);
    connect(reply, SIGNAL(finished()), this, SLOT(getTaskReply()));
}

void UCtrlAPI::getTaskReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (!checkNetworkError(reply)) {
        reply->deleteLater();
        return;
    }

    QJsonObject jsonObj = QJsonDocument::fromJson(reply->readAll()).object();
    if (!checkServerError(jsonObj)) {
        reply->deleteLater();
        return;
    }

    QString platformId = reply->property(PlatformId).toString();
    QString deviceId = reply->property(DeviceId).toString();
    QString scenarioId = reply->property(ScenarioId).toString();

    NestedListItem* platform = (NestedListItem*)m_platforms->find(platformId);
    if (!checkModel(platform)) {
        reply->deleteLater();
        return;
    }

    NestedListItem* device = (NestedListItem*)platform->nestedModel()->find(deviceId);
    if (!checkModel(device)) {
        reply->deleteLater();
        return;
    }

    NestedListItem* scenario = (NestedListItem*)device->nestedModel()->find(scenarioId);
    if (!checkModel(scenario)) {
        reply->deleteLater();
        return;
    }

    ListItem* task = scenario->nestedModel()->find(scenarioId);
    if (!checkModel(scenario)) {
        reply->deleteLater();
        return;
    }

    task->read(jsonObj);

    reply->deleteLater();
}

// Update a specified task.
void UCtrlAPI::putTask(const QString& platformId, const QString& deviceId, const QString& scenarioId, const QString& taskId)
{
    NestedListItem* platform = (NestedListItem*)m_platforms->find(platformId);
    if (!checkModel(platform))
        return;

    NestedListItem* device = (NestedListItem*)platform->nestedModel()->find(deviceId);
    if (!checkModel(device))
        return;

    NestedListItem* scenario = (NestedListItem*)device->nestedModel()->find(scenarioId);
    if (!checkModel(scenario))
        return;

    ListItem* task = scenario->nestedModel()->find(taskId);
    if (!checkModel(task))
        return;

    QNetworkReply* reply = putRequest(QString("platforms/%1/devices/%2/scenarios/%3/tasks/%4").arg(platformId, deviceId, scenarioId, taskId), task);
    connect(reply, SIGNAL(finished()), this, SLOT(putTaskReply()));
}

void UCtrlAPI::putTaskReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());

    if (!checkNetworkError(reply)) {
        checkServerError(QJsonDocument::fromJson(reply->readAll()).object());
    }

    reply->deleteLater();
}

// Delete a Task.
void UCtrlAPI::deleteTask(const QString& platformId, const QString& deviceId, const QString& scenarioId, const QString& taskId)
{
    QNetworkReply* reply = deleteRequest(QString("platforms/%1/devices/%2/scenarios/%3/tasks/%4").arg(platformId, deviceId, scenarioId, taskId));
    connect(reply, SIGNAL(finished()), this, SLOT(deleteTaskReply()));
}

void UCtrlAPI::deleteTaskReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());

    if (!checkNetworkError(reply)) {
        checkServerError(QJsonDocument::fromJson(reply->readAll()).object());
    }

    reply->deleteLater();
}

// /////////////////////////////////////
//           Conditions               //
// /////////////////////////////////////


void UCtrlAPI::getConditions(const QString& platformId, const QString& deviceId, const QString& scenarioId, const QString& taskId)
{
    QNetworkReply* reply = getRequest(QString("platforms/%1/devices/%2/scenarios/%3/tasks/%4/conditions").arg(platformId, deviceId, scenarioId, taskId));
    reply->setProperty(PlatformId, platformId);
    reply->setProperty(DeviceId, deviceId);
    reply->setProperty(ScenarioId, scenarioId);
    reply->setProperty(TaskId, taskId);
    connect(reply, SIGNAL(finished()), this, SLOT(getConditionsReply()));
}

void UCtrlAPI::getConditionsReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (!checkNetworkError(reply)) {
        reply->deleteLater();
        return;
    }

    QString platformId = reply->property(PlatformId).toString();
    QString deviceId = reply->property(DeviceId).toString();
    QString scenarioId = reply->property(ScenarioId).toString();
    QString taskId = reply->property(TaskId).toString();

    QJsonObject jsonObj = QJsonDocument::fromJson(reply->readAll()).object();
    if (!checkServerError(jsonObj)) {
        reply->deleteLater();
        return;
    }

    NestedListItem* platform = (NestedListItem*)m_platforms->find(platformId);
    if (!checkModel(platform)) {
        reply->deleteLater();
        return;
    }

    NestedListItem* device = (NestedListItem*)platform->nestedModel()->find(deviceId);
    if (!checkModel(device)) {
        reply->deleteLater();
        return;
    }

    NestedListItem* scenario = (NestedListItem*)device->nestedModel()->find(scenarioId);
    if (!checkModel(scenario)) {
        reply->deleteLater();
        return;
    }

    NestedListItem* task = (NestedListItem*)scenario->nestedModel()->find(taskId);
    if (!checkModel(task)) {
        reply->deleteLater();
        return;
    }

    task->nestedModel()->read(jsonObj);

    reply->deleteLater();
}

void UCtrlAPI::postCondition(const QString& platformId, const QString& deviceId, const QString& scenarioId, const QString& taskId, const QString& conditionId)
{
    NestedListItem* platform = (NestedListItem*)m_platforms->find(platformId);
    if (!checkModel(platform))
        return;

    NestedListItem* device = (NestedListItem*)platform->nestedModel()->find(deviceId);
    if (!checkModel(device))
        return;

    NestedListItem* scenario = (NestedListItem*)device->nestedModel()->find(scenarioId);
    if (!checkModel(scenario))
        return;

    NestedListItem* task = (NestedListItem*)scenario->nestedModel()->find(taskId);
    if (!checkModel(task))
        return;

    NestedListItem* condition = (NestedListItem*)task->nestedModel()->find(conditionId);
    if (!checkModel(condition))
        return;


    QNetworkReply* reply = postRequest(QString("platforms/%1/devices/%2/scenarios/%3/tasks/%4/conditions").arg(platformId, deviceId, scenarioId, taskId), condition);
    reply->setProperty(ConditionPtr, (long long)condition);
    connect(reply, SIGNAL(finished()), this, SLOT(postConditionReply()));
}

void UCtrlAPI::postConditionReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());

    QJsonObject jsonConditionReply = QJsonDocument::fromJson(reply->readAll()).object();
    if (!checkNetworkError(reply)) {
        checkServerError(jsonConditionReply);
    }

    UCondition* condition = (UCondition*)reply->property(ConditionPtr).toLongLong();
    condition->read(jsonConditionReply["condition"].toObject());

    reply->deleteLater();
}

void UCtrlAPI::getCondition(const QString& platformId, const QString& deviceId, const QString& scenarioId, const QString& taskId, const QString& conditionId)
{
    QNetworkReply* reply = getRequest(QString("platforms/%1/devices/%2/scenarios/%3/tasks/%4/conditions/%5").arg(platformId, deviceId, scenarioId, taskId, conditionId));
    reply->setProperty(PlatformId, platformId);
    reply->setProperty(DeviceId, deviceId);
    reply->setProperty(ScenarioId, scenarioId);
    reply->setProperty(TaskId, taskId);
    reply->setProperty(ConditionId, conditionId);
    connect(reply, SIGNAL(finished()), this, SLOT(getConditionReply()));
}

void UCtrlAPI::getConditionReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (!checkNetworkError(reply)) {
        reply->deleteLater();
        return;
    }

    QJsonObject jsonObj = QJsonDocument::fromJson(reply->readAll()).object();
    if (!checkServerError(jsonObj)) {
        reply->deleteLater();
        return;
    }

    QString platformId = reply->property(PlatformId).toString();
    QString deviceId = reply->property(DeviceId).toString();
    QString scenarioId = reply->property(ScenarioId).toString();
    QString taskId = reply->property(TaskId).toString();
    QString conditionId = reply->property(ConditionId).toString();

    NestedListItem* platform = (NestedListItem*)m_platforms->find(platformId);
    if (!checkModel(platform)) {
        reply->deleteLater();
        return;
    }

    NestedListItem* device = (NestedListItem*)platform->nestedModel()->find(deviceId);
    if (!checkModel(device)) {
        reply->deleteLater();
        return;
    }

    NestedListItem* scenario = (NestedListItem*)device->nestedModel()->find(scenarioId);
    if (!checkModel(scenario)) {
        reply->deleteLater();
        return;
    }

    NestedListItem* task = (NestedListItem*)scenario->nestedModel()->find(taskId);
    if (!checkModel(task)) {
        reply->deleteLater();
        return;
    }

    ListItem* condition = task->nestedModel()->find(conditionId);
    if (!checkModel(condition)) {
        reply->deleteLater();
        return;
    }

    condition->read(jsonObj);

    reply->deleteLater();
}

void UCtrlAPI::putCondition(const QString& platformId, const QString& deviceId, const QString& scenarioId, const QString& taskId, const QString& conditionId)
{
    NestedListItem* platform = (NestedListItem*)m_platforms->find(platformId);
    if (!checkModel(platform))
        return;

    NestedListItem* device = (NestedListItem*)platform->nestedModel()->find(deviceId);
    if (!checkModel(device))
        return;

    NestedListItem* scenario = (NestedListItem*)device->nestedModel()->find(scenarioId);
    if (!checkModel(scenario))
        return;

    NestedListItem* task = (NestedListItem*)scenario->nestedModel()->find(taskId);
    if (!checkModel(task))
        return;

    NestedListItem* condition = (NestedListItem*)task->nestedModel()->find(conditionId);
    if (!checkModel(condition))
        return;

    QNetworkReply* reply = putRequest(QString("platforms/%1/devices/%2/scenarios/%3/tasks/%4/conditions/%5").arg(platformId, deviceId, scenarioId, taskId, conditionId), condition);
    connect(reply, SIGNAL(finished()), this, SLOT(putConditionReply()));
}

void UCtrlAPI::putConditionReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());

    if (!checkNetworkError(reply)) {
        checkServerError(QJsonDocument::fromJson(reply->readAll()).object());
    }

    reply->deleteLater();
}

void UCtrlAPI::deleteCondition(const QString& platformId, const QString& deviceId, const QString& scenarioId, const QString& taskId, const QString& conditionId)
{
    QNetworkReply* reply = deleteRequest(QString("platforms/%1/devices/%2/scenarios/%3/tasks/%4/conditions/%5").arg(platformId, deviceId, scenarioId, taskId, conditionId));
    connect(reply, SIGNAL(finished()), this, SLOT(deleteConditionReply()));
}

void UCtrlAPI::ninjaToken(const QString &ninjaToken)
{
    if (m_ninjaToken != ninjaToken ) {
        m_ninjaToken = ninjaToken;
    }
}

const QString &UCtrlAPI::ninjaToken()
{
    return m_ninjaToken;
}

void UCtrlAPI::serverBaseUrl(const QString &serverBaseUrl)
{
    if (m_serverBaseUrl != serverBaseUrl ) {
        m_serverBaseUrl = serverBaseUrl;
    }
}

const QString &UCtrlAPI::serverBaseUrl()
{
    return m_serverBaseUrl;
}

void UCtrlAPI::deleteConditionReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());

    if (!checkNetworkError(reply)) {
        checkServerError(QJsonDocument::fromJson(reply->readAll()).object());
    }

    reply->deleteLater();
}

void UCtrlAPI::onConnected()
{
    connect(&m_webSocket, SIGNAL(textMessageReceived(QString)), this, SLOT(onMessageReceived(QString)));

    QJsonObject tokenObj;
    tokenObj["token"] = m_userToken;
    QJsonDocument doc(tokenObj);

    m_webSocket.sendTextMessage(QString(doc.toJson()));
}

void UCtrlAPI::onMessageReceived(const QString &message)
{
    Q_UNUSED(message)
    // TODO: Dispatch to alerts or system or whatever
}

void UCtrlAPI::onClosed()
{
    // TODO: Error I guess!?
}

void UCtrlAPI::synchronize()
{
    m_platforms->clear();
    postUser();
}

void UCtrlAPI::getRecommendations()
{
    QNetworkReply* reply = getRequest(QString("recommendations"));
    connect(reply, SIGNAL(finished()), this, SLOT(getRecommendationsReply()));
}

void UCtrlAPI::getRecommendationsReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (!checkNetworkError(reply)) {
        reply->deleteLater();
        return;
    }

    QJsonObject jsonObj = QJsonDocument::fromJson(reply->readAll()).object();
    if (!checkServerError(jsonObj)) {
        reply->deleteLater();
        return;
    }

    RecommendationsModel* recModel = (RecommendationsModel*)m_platforms->getRecommendations();
    if (!recModel) {
        reply->deleteLater();
        return;
    }

    recModel->read(jsonObj);

    reply->deleteLater();
}

void UCtrlAPI::acceptRecommendation(const QString &id)
{
    RecommendationsModel* recModel = (RecommendationsModel*)m_platforms->getRecommendations();
    Recommendation* rec = (Recommendation*)recModel->find(id);

    QNetworkReply* reply = putRequest(QString("recommendations"), rec);
    connect(reply, SIGNAL(finished()), this, SLOT(acceptRecommendationReply()));
}

void UCtrlAPI::acceptRecommendationReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());

    if (!checkNetworkError(reply)) {
        checkServerError(QJsonDocument::fromJson(reply->readAll()).object());
    }

    reply->deleteLater();
}

// /////////////////////////////////////
//             Helpers                //
// /////////////////////////////////////

bool UCtrlAPI::checkNetworkError(QNetworkReply* reply)
{
    bool noError = reply->error() == QNetworkReply::NoError;
    if (!noError) {
        QString errorString = "Network error (" + QString::number((int)reply->error()) + ")";
        emit networkError(errorString);
    }
    return noError;
}

bool UCtrlAPI::checkServerError(const QJsonObject& jsonObj)
{
    bool status = jsonObj["status"].toBool();
    if (!status) {
        emit serverError(QString(jsonObj["error"].toString()));
    }
    return status;
}

bool UCtrlAPI::checkModel(ListItem* item)
{
    if (!item) {
        emit modelError("Couldn't find item");
    }
    return !!item;
}

QNetworkReply* UCtrlAPI::getRequest(const QString &urlString, QMap<QString, QVariant> params)
{
    QUrl url(m_serverBaseUrl + urlString);

    if (!params.empty()) {
        QUrlQuery urlParams;

        QMap<QString, QVariant>::iterator i;
        for (i = params.begin(); i != params.end(); ++i)
             urlParams.addQueryItem(i.key(), i.value().toString());

        url.setQuery(urlParams);
    }

    QNetworkRequest req(url);
    req.setRawHeader("X-uCtrl-Token", m_userToken.toUtf8());
    return m_networkAccessManager->get(req);
}

QNetworkReply* UCtrlAPI::postRequest(const QString &urlString, JsonWritable* data)
{
    QUrl url(m_serverBaseUrl + urlString);
    QNetworkRequest req(url);
    req.setRawHeader("X-uCtrl-Token", m_userToken.toUtf8());
    req.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    return m_networkAccessManager->post(req, JsonSerializer::serialize(data));
}

QNetworkReply* UCtrlAPI::putRequest(const QString &urlString, JsonWritable* data)
{
    QUrl url(m_serverBaseUrl + urlString);
    QNetworkRequest req(url);
    req.setRawHeader("X-uCtrl-Token", m_userToken.toUtf8());
    req.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    return m_networkAccessManager->put(req, JsonSerializer::serialize(data));
}

QNetworkReply* UCtrlAPI::deleteRequest(const QString &urlString)
{
    QUrl url(m_serverBaseUrl + urlString);
    QNetworkRequest req(url);
    req.setRawHeader("X-uCtrl-Token", m_userToken.toUtf8());
    return m_networkAccessManager->deleteResource(req);
}
