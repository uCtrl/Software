#include "uninjablocksapi.h"

UNinjaBlocksAPI::UNinjaBlocksAPI(QNetworkAccessManager* nam, QObject *parent) :
    QObject(parent), m_networkAccessManager(nam)
{
}




// /////////////////////////////////////
//              User                  //
// /////////////////////////////////////

// Return information about the authenticated user
// Needs to be implemented in server. No route for /user at the moment
void UNinjaBlocksAPI::getUser()
{  
    QNetworkReply* reply = getRequest("user");
    connect(reply, SIGNAL(finished()), this, SLOT(getUserReply()));
}

void UNinjaBlocksAPI::getUserReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}


// Returns the 30 most recent entries in the authenticating user's activity stream
// Needs to be implemented in server. No route for /user/stream at the moment
void UNinjaBlocksAPI::getUserStream()
{
    QNetworkReply* reply = getRequest("user/stream");
    connect(reply, SIGNAL(finished()), this, SLOT(getUserStreamReply()));
}

void UNinjaBlocksAPI::getUserStreamReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}


// Returns user's pusher channel key
// Needs to be implemented in server. No route for /user/pusherchannel at the moment
void UNinjaBlocksAPI::getUserPusherChannel()
{
    QNetworkReply* reply = getRequest("user/pusherchannel");
    connect(reply, SIGNAL(finished()), this, SLOT(getUserStreamReply()));
}

void UNinjaBlocksAPI::getUserPusherChannelReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}

// Sets the amount of time that 'realtime' mode will be active for
// Needs to be implemented in server. No route for /user/realtime at the moment
void UNinjaBlocksAPI::putUserRealtime(int length)
{
    QJsonObject obj;
    obj["length"] = length;
    QJsonDocument doc(obj);

    QNetworkReply* reply = putRequest("user/realtime", doc.toJson());
    connect(reply, SIGNAL(finished()), this, SLOT(getUserStreamReply()));
}

void UNinjaBlocksAPI::putUserRealtimeReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}





// /////////////////////////////////////
//            Platforms               //
// /////////////////////////////////////


// Fetch all claimed platforms
void UNinjaBlocksAPI::getPlatforms()
{
    QNetworkReply* reply = getRequest("platforms");
    connect(reply, SIGNAL(finished()), this, SLOT(getBlocksReply()));
}

void UNinjaBlocksAPI::getPlatformsReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}




// Attempt to claim an unclaimed block.
// Needs more impletation in server (platforms.js)

void UNinjaBlocksAPI::postPlatforms(const QString& nodeId)
{
    QJsonObject obj;
    obj["nodeid"] = nodeId;
    QJsonDocument doc(obj);

    QNetworkReply* reply = postRequest("platforms", doc.toJson());
    connect(reply, SIGNAL(finished()), this, SLOT(postPlatformsReply()));
}

void UNinjaBlocksAPI::postPlatformsReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}





// Returns data about the specified block.
void UNinjaBlocksAPI::getPlatform(const QString& nodeId)
{
    QNetworkReply* reply = getRequest(QString("platforms/%1").arg(nodeId));
    connect(reply, SIGNAL(finished()), this, SLOT(getPlatformReply()));
}

void UNinjaBlocksAPI::getPlatformReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}




// Unpair a block.
void UNinjaBlocksAPI::deletePlatform(const QString& nodeId)
{
    QNetworkReply* reply = deleteRequest(QString("platforms/%1").arg(nodeId));
    connect(reply, SIGNAL(finished()), this, SLOT(deletePlatformReply()));
}

void UNinjaBlocksAPI::deletePlatformReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}



/*
 * Not in the µCtrl protocol but available with ninjablocks. so do we have to upgrade µCtrl protocol with that ?
 *
 * GET   block/:nodeId/activate  => Activate a block and return its token.
 * POST  block/:nodeId/heartbeat =>	[DEPRECATED] Send a heartbeat from this block.
 * POST  block/:nodeId/data      =>	Send a 'data' event from this block. Typically 'data' events will be instantly actioned, as opposed to heartbeats which may be queued.
 * POST  block/:nodeId/config    => Config events are intended to be meta information about a device, for example it's IP address if it were an IP camera.
 * GET   block/:nodeId/commands  =>	Long GET that will respond with that block's commands for the duration of the request.
 * POST  camera/:guid/snapshot   =>	Send an image that has been requested via a 'snapshot' command.
 *
 *
 * */






// /////////////////////////////////////
//             Devices                //
// /////////////////////////////////////



// Returns the list of devices associated to a specified platform
void UNinjaBlocksAPI::getDevices(const QString& nodeId)
{
    QNetworkReply* reply = getRequest(QString("platforms/%1/devices").arg(nodeId));
    connect(reply, SIGNAL(finished()), this, SLOT(getDevicesReply()));
}

void UNinjaBlocksAPI::getDevicesReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}



// Create new device
// Maybe not available for device. (Only for sub devices ?)



// Fetch data about the specified device.
void UNinjaBlocksAPI::getDevice(const QString& nodeId, const QString& guid)
{
    QNetworkReply* reply = getRequest(QString("platforms/%1/devices/%2").arg(nodeId).arg(guid));
    connect(reply, SIGNAL(finished()), this, SLOT(getDeviceReply()));
}

void UNinjaBlocksAPI::getDeviceReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}





// Update a device, including sending a command.
// Needs implementation in server (devices.js)

void UNinjaBlocksAPI::putDevice(const QString& nodeId, const QString& guid, const QString& da, const QString& shortName)
{
    QJsonObject obj;
    if (da != NULL) obj["DA"] = da;
    if (shortName != NULL) obj["shortName"] = shortName;
    QJsonDocument doc(obj);

    QNetworkReply* reply = putRequest(QString("platforms/%1/device/%2").arg(nodeId).arg(guid), doc.toJson());
    connect(reply, SIGNAL(finished()), this, SLOT(putDeviceReply()));
}

void UNinjaBlocksAPI::putDeviceReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}



// Delete this device from the system.
// needs implementation in server (devices.js)

void UNinjaBlocksAPI::deleteDevice(const QString& nodeId, const QString& guid)
{
    QNetworkReply* reply = deleteRequest(QString("platforms/%1/device/%2").arg(nodeId).arg(guid));
    connect(reply, SIGNAL(finished()), this, SLOT(deleteDeviceReply()));
}

void UNinjaBlocksAPI::deleteDeviceReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}



/*
 * Not in the µCtrl protocol but available with ninjablocks. so do we have to upgrade µCtrl protocol with that ?
 *
 * GET     device/:guid/data                  Return the historical data for the specified device.
 * GET     device/:guid/heartbeat             Return the last heartbeat for the specified device.
 * POST    device/:guid/callback              Register a new callback against this device.
 * GET     device/:guid/callback              Retrieve the current callback url registered against this device.
 * PUT     device/:guid/callback              Update an existing callback against this device.
 * DELETE  device/:guid/callback              Delete an existing callback against this device.
 *
 *
 *
 *
 *
 * La notion de "Sub-device" n'est pas gérée par le protocol µCtrl coté server actuellement
 *
 * POST    device/:guid/subdevice             Create a new sub-device under this device.
 * PUT     device/:guid/subdevice/:subdeviceId          Update information about the specified sub-device.
 * DELETE  device/:guid/subdevice/:subdeviceId          Delete the specified sub-device. Note that if there are any rules attached to this sub-device they will not be deleted, but instead become ineffectual.
 * GET     device/:guid/subdevice/:subdeviceId/data     Fetch the count of the number of times the sub-device was actuated.
 * POST    device/:deviceGuid/subdevice/:subDeviceId/tickle/:token      Tickle a 'webhook' sub-device.
 *
 *
 * */





// /////////////////////////////////////
//             Scenarii               //
// /////////////////////////////////////



// Fetch all the existing scenarii about a specified device

void UNinjaBlocksAPI::getScenarios(const QString& nodeId, const QString& guid)
{
    QNetworkReply* reply = getRequest(QString("platforms/%1/devices/%2/scenarios").arg(nodeId).arg(guid));
    connect(reply, SIGNAL(finished()), this, SLOT(getScenariosReply()));
}

void UNinjaBlocksAPI::getScenariosReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}


// Create a new scenario for specified device
// Needs implementation right here
void UNinjaBlocksAPI::postScenarios(const QString& nodeId, const QString& guid)
{

}

void UNinjaBlocksAPI::postScenariosReply()
{

}




// Fetch data about a specified scenario for a specified device
// Needs implementation in server (scenarios.js)
void UNinjaBlocksAPI::getScenario(const QString& nodeId, const QString& guid, const QString& scenarioId)
{
    QNetworkReply* reply = getRequest(QString("platforms/%1/devices/%2/scenarios/%3").arg(nodeId).arg(guid).arg(scenarioId));
    connect(reply, SIGNAL(finished()), this, SLOT(getScenarioReply()));
}

void UNinjaBlocksAPI::getScenarioReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}


// Update a specified scenario
// Needs implementation right here
void UNinjaBlocksAPI::putScenario(const QString& nodeId, const QString& guid, const QString& scenarioId)
{

}

void UNinjaBlocksAPI::putScenarioReply()
{

}



// Delete a specified scenario
void UNinjaBlocksAPI::deleteScenario(const QString& nodeId, const QString& guid, const QString& scenarioId)
{
    QNetworkReply* reply = deleteRequest(QString("platforms/%1/devices/%2/scenarios/%3").arg(nodeId).arg(guid).arg(scenarioId));
    connect(reply, SIGNAL(finished()), this, SLOT(deleteScenarioReply()));
}

void UNinjaBlocksAPI::deleteScenarioReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}




// /////////////////////////////////////
//               Task                 //
// /////////////////////////////////////




// Fetch all of a scenario's tasks.
void UNinjaBlocksAPI::getTasks(const QString& nodeId, const QString& guid, const QString& scenarioId)
{
    QNetworkReply* reply = getRequest(QString("platforms/%1/devices/%2/scenarios/%3/tasks").arg(nodeId).arg(guid).arg(scenarioId));
    connect(reply, SIGNAL(finished()), this, SLOT(getTasksReply()));
}

<<<<<<< HEAD
void UNinjaBlocksAPI::getTasksReply()
=======
void UNinjaBlocksAPI::geTasksReply()
>>>>>>> f550317f2424b18c4bfe85699f0491153d5f714f
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}



// Create a new tasks
void UNinjaBlocksAPI::postTasks(const QString& nodeId, const QString& guid, const QString& scenarioId, const QString& shortName, const QString& preConditions, const QString& actions, const QString& timeout)
{
    QJsonObject obj;
    obj["shortName"] = shortName;
    obj["preconditions"] = preConditions;
    obj["actions"] = actions;
    if (timeout != NULL) obj["timeout"] = timeout;
    QJsonDocument doc(obj);

<<<<<<< HEAD
    QNetworkReply* reply = postRequest(QString("platforms/%1/devices/%2/scenarios/%3/tasks").arg(nodeId).arg(guid).arg(scenarioId), doc.toJson());
=======
    QNetworkReply* reply = postRequest(QString("platforms/%1/devices/%2/scenarios/%3/tasks").arg(nodeId).arg(guid).arg(scenarioId));
>>>>>>> f550317f2424b18c4bfe85699f0491153d5f714f
    connect(reply, SIGNAL(finished()), this, SLOT(postTasksReply()));
}

void UNinjaBlocksAPI::postTasksReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}






// Fetch data about a specified task
void UNinjaBlocksAPI::getTask(const QString& nodeId, const QString& guid, const QString& scenarioId, const QString& taskId)
{
    QNetworkReply* reply = getRequest(QString("platforms/%1/devices/%2/scenarios/%3/tasks/%4").arg(nodeId).arg(guid).arg(scenarioId).arg(taskId));
    connect(reply, SIGNAL(finished()), this, SLOT(getTaskReply()));
}

void UNinjaBlocksAPI::getTaskReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}


// Update a specified task.
void UNinjaBlocksAPI::putTask(const QString& nodeId, const QString& guid, const QString& scenarioId, const QString& taskId, const QString& shortName, const QString& preConditions, const QString& actions, const QString& timeout)
{
    QJsonObject obj;
    obj["shortName"] = shortName;
    obj["preconditions"] = preConditions;
    obj["actions"] = actions;
    if (timeout != NULL) obj["timeout"] = timeout;
    QJsonDocument doc(obj);

<<<<<<< HEAD
    QNetworkReply* reply = putRequest(QString("platforms/%1/devices/%2/scenarios/%3/tasks/%4").arg(nodeId).arg(guid).arg(scenarioId).arg(taskId), doc.toJson());
=======
    QNetworkReply* reply = putRequest(QString("platforms/%1/devices/%2/scenarios/%3/tasks/%4").arg(nodeId).arg(guid).arg(scenarioId).arg(taskId));
>>>>>>> f550317f2424b18c4bfe85699f0491153d5f714f
    connect(reply, SIGNAL(finished()), this, SLOT(putTaskReply()));
}

void UNinjaBlocksAPI::putTaskReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

}

// Delete a Task.
void UNinjaBlocksAPI::deleteTask(const QString& nodeId, const QString& guid, const QString& scenarioId, const QString& taskId)
{
    QNetworkReply* reply = deleteRequest(QString("platforms/%1/devices/%2/scenarios/%3/tasks/%4").arg(nodeId).arg(guid).arg(scenarioId).arg(taskId));
    connect(reply, SIGNAL(finished()), this, SLOT(deleteTaskReply()));
}

void UNinjaBlocksAPI::deleteTaskReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}


/*
 * Not in the µCtrl protocol but available with ninjablocks. so do we have to upgrade µCtrl protocol with that ?
 *
 * POST     rule/:rid/suspend	Suspend a rule.
 * DELETE   rule/:rid/suspend	Unsuspend a rule
 *
 *
 * */








QNetworkReply* UNinjaBlocksAPI::getRequest(const QString &urlString)
{
    QUrl url(NinjaBaseUrl + urlString);
    QUrlQuery urlQuery;
    urlQuery.addQueryItem("user_access_token", UserAccessToken);
    url.setQuery(urlQuery);
    QNetworkRequest req(url);
    return m_networkAccessManager->get(req);
}

QNetworkReply* UNinjaBlocksAPI::postRequest(const QString &urlString, const QByteArray& data)
{
    QUrl url(NinjaBaseUrl + urlString);
    QUrlQuery urlQuery;
    urlQuery.addQueryItem("user_access_token", UserAccessToken);
    url.setQuery(urlQuery);
    QNetworkRequest req(url);
    return m_networkAccessManager->post(req, data);
}

QNetworkReply* UNinjaBlocksAPI::putRequest(const QString &urlString, const QByteArray& data)
{
    QUrl url(NinjaBaseUrl + urlString);
    QUrlQuery urlQuery;
    urlQuery.addQueryItem("user_access_token", UserAccessToken);
    url.setQuery(urlQuery);
    QNetworkRequest req(url);
    return m_networkAccessManager->put(req, data);
}

QNetworkReply* UNinjaBlocksAPI::deleteRequest(const QString &urlString)
{
    QUrl url(NinjaBaseUrl + urlString);
    QUrlQuery urlQuery;
    urlQuery.addQueryItem("user_access_token", UserAccessToken);
    url.setQuery(urlQuery);
    QNetworkRequest req(url);
    return m_networkAccessManager->deleteResource(req);
}
