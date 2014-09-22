#include "uninjablocksapi.h"

UNinjaBlocksAPI::UNinjaBlocksAPI(QNetworkAccessManager* nam, QObject *parent) :
    QObject(parent), m_networkAccessManager(nam)
{
}

// Return information about the authenticated user
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

// Fetch all claimed blocks
void UNinjaBlocksAPI::getBlocks()
{
    QNetworkReply* reply = getRequest("block");
    connect(reply, SIGNAL(finished()), this, SLOT(getBlocksReply()));
}

void UNinjaBlocksAPI::getBlocksReply()
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
void UNinjaBlocksAPI::postBlock(const QString& nodeId)
{
    QJsonObject obj;
    obj["nodeid"] = nodeId;
    QJsonDocument doc(obj);

    QNetworkReply* reply = postRequest("block", doc.toJson());
    connect(reply, SIGNAL(finished()), this, SLOT(postBlocksReply()));
}

void UNinjaBlocksAPI::postBlockReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}

// Activate a block and return its token. This token should be used with all subsequent requests. Your nodeId should be a 12+ alphanumeric character identifier, ideally a unique serial number.
void UNinjaBlocksAPI::getBlockActivate(const QString& nodeId)
{
    QNetworkReply* reply = getRequest(QString("block/%1/activate").arg(nodeId));
    connect(reply, SIGNAL(finished()), this, SLOT(getBlockActivateReply()));
}

void UNinjaBlocksAPI::getBlockActivateReply()
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
void UNinjaBlocksAPI::getBlock(const QString& nodeId)
{
    QNetworkReply* reply = getRequest(QString("block/%1").arg(nodeId));
    connect(reply, SIGNAL(finished()), this, SLOT(getBlockReply()));
}

void UNinjaBlocksAPI::getBlockReply()
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
void UNinjaBlocksAPI::deleteBlock(const QString& nodeId)
{
    QNetworkReply* reply = deleteRequest(QString("block/%1").arg(nodeId));
    connect(reply, SIGNAL(finished()), this, SLOT(deleteBlockReply()));
}

void UNinjaBlocksAPI::deleteBlockReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}


// Returns the list of devices associated with the authenticating user
void UNinjaBlocksAPI::getDevices()
{
    QNetworkReply* reply = getRequest("devices");
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

// Fetch metadata about the specified device.
void UNinjaBlocksAPI::getDevice(const QString& guid)
{
    QNetworkReply* reply = getRequest(QString("device/%1").arg(guid));
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
void UNinjaBlocksAPI::putDevice(const QString& guid, const QString& da, const QString& shortName)
{
    QJsonObject obj;
    if (da != NULL) obj["DA"] = da;
    if (shortName != NULL) obj["shortName"] = shortName;
    QJsonDocument doc(obj);

    QNetworkReply* reply = putRequest(QString("device/%1").arg(guid), doc.toJson());
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
void UNinjaBlocksAPI::deleteDevice(const QString& guid)
{
    QNetworkReply* reply = deleteRequest(QString("device/%1").arg(guid));
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

// Return the last heartbeat for the specified device.
void UNinjaBlocksAPI::getDeviceHeartbeat(const QString& guid)
{
    QNetworkReply* reply = getRequest(QString("device/%1/heartbeat").arg(guid));
    connect(reply, SIGNAL(finished()), this, SLOT(getDeviceHeartbeatReply()));
}

void UNinjaBlocksAPI::getDeviceHeartbeatReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}

// Return the historical data for the specified device.
void UNinjaBlocksAPI::getDeviceData(const QString& guid, const QString& from, const QString& to, const QString& interval, const QString& fn)
{
    QUrl url(NinjaBaseUrl + QString("device/%1/data").arg(guid));
    QUrlQuery urlQuery;
    urlQuery.addQueryItem("from", from);
    urlQuery.addQueryItem("to", to);
    urlQuery.addQueryItem("interval", interval);
    urlQuery.addQueryItem("fn", fn);
    urlQuery.addQueryItem("user_access_token", UserAccessToken);
    url.setQuery(urlQuery);
    QNetworkRequest req(url);

    QNetworkReply* reply =  m_networkAccessManager->get(req);
    connect(reply, SIGNAL(finished()), this, SLOT(getDeviceDataReply()));
}

void UNinjaBlocksAPI::getDeviceDataReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}

// Register a new callback against this device.
void UNinjaBlocksAPI::postDeviceCallback(const QString& guid, const QString& url)
{
    QJsonObject obj;
    obj["url"] = url;
    QJsonDocument doc(obj);

    QNetworkReply* reply = postRequest(QString("device/%1/callback").arg(guid), doc.toJson());
    connect(reply, SIGNAL(finished()), this, SLOT(postDeviceCallbackReply()));
}

void UNinjaBlocksAPI::postDeviceCallbackReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}

// Register a new callback against this device.
void UNinjaBlocksAPI::getDeviceCallback(const QString& guid)
{
    QNetworkReply* reply = getRequest(QString("device/%1/callback").arg(guid));
    connect(reply, SIGNAL(finished()), this, SLOT(getDeviceCallbackReply()));
}

void UNinjaBlocksAPI::getDeviceCallbackReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}

// Register a new callback against this device.
void UNinjaBlocksAPI::putDeviceCallback(const QString& guid, const QString& url)
{
    QJsonObject obj;
    obj["url"] = url;
    QJsonDocument doc(obj);

    QNetworkReply* reply = putRequest(QString("device/%1/callback").arg(guid), doc.toJson());
    connect(reply, SIGNAL(finished()), this, SLOT(putDeviceCallbackReply()));
}

void UNinjaBlocksAPI::putDeviceCallbackReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}

// Delete an existing callback against this device.
void UNinjaBlocksAPI::deleteDeviceCallback(const QString& guid)
{
    QNetworkReply* reply = deleteRequest(QString("device/%1/callback").arg(guid));
    connect(reply, SIGNAL(finished()), this, SLOT(deleteDeviceCallbackReply()));
}

void UNinjaBlocksAPI::deleteDeviceCallbackReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}

// Create a new sub-device under this device.
void UNinjaBlocksAPI::postSubdevice(const QString& guid, const QString& category, const QString& type, const QString& shortName, const QString& data, const QString& url)
{
    QJsonObject obj;
    obj["category"] = category;
    obj["type"] = type;
    obj["shortName"] = shortName;
    if (data != NULL) obj["data"] = data;
    if (url != NULL) obj["url"] = url;
    QJsonDocument doc(obj);

    QNetworkReply* reply = postRequest(QString("device/%1/subdevice").arg(guid), doc.toJson());
    connect(reply, SIGNAL(finished()), this, SLOT(postSubdeviceReply()));
}

void UNinjaBlocksAPI::postSubdeviceReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}


// Update information about the specified sub-device.
void UNinjaBlocksAPI::putSubdevice(const QString& guid, const QString& subDeviceId, const QString& category, const QString& type, const QString& shortName, const QString& data, const QString& url)
{
    QJsonObject obj;
    if (category != NULL) obj["category"] = category;
    if (type != NULL) obj["type"] = type;
    if (shortName != NULL) obj["shortName"] = shortName;
    if (data != NULL) obj["data"] = data;
    if (url != NULL) obj["url"] = url;
    QJsonDocument doc(obj);

    QNetworkReply* reply = putRequest(QString("device/%1/subdevice/%2").arg(guid, subDeviceId), doc.toJson());
    connect(reply, SIGNAL(finished()), this, SLOT(putSubdeviceReply()));
}

void UNinjaBlocksAPI::putSubdeviceReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}

// Delete the specified sub-device. Note that if there are any rules attached to this sub-device they will not be deleted, but instead become ineffectual.
void UNinjaBlocksAPI::deleteSubdevice(const QString& guid, const QString& subDeviceId)
{
    QNetworkReply* reply = deleteRequest(QString("device/%1/subdevice/%2").arg(guid, subDeviceId));
    connect(reply, SIGNAL(finished()), this, SLOT(deleteSubdeviceReply()));
}

void UNinjaBlocksAPI::deleteSubdeviceReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}

// Fetch the count of the number of times the sub-device was actuated.
void UNinjaBlocksAPI::getSubdeviceData(const QString& guid, const QString& subDeviceId, const QString& from, const QString& to, const QString& interval)
{
    QUrl url(NinjaBaseUrl + QString("device/%1/subdevice/%2").arg(guid, subDeviceId));
    QUrlQuery urlQuery;
    urlQuery.addQueryItem("from", from);
    urlQuery.addQueryItem("to", to);
    urlQuery.addQueryItem("interval", interval);
    urlQuery.addQueryItem("user_access_token", UserAccessToken);
    url.setQuery(urlQuery);
    QNetworkRequest req(url);

    QNetworkReply* reply =  m_networkAccessManager->get(req);
    connect(reply, SIGNAL(finished()), this, SLOT(getSubdeviceDataReply()));
}

void UNinjaBlocksAPI::getSubdeviceDataReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}

// Fetch all of a user's rules.
void UNinjaBlocksAPI::getRules()
{
    QNetworkReply* reply = getRequest("rule");
    connect(reply, SIGNAL(finished()), this, SLOT(getRulesReply()));
}

void UNinjaBlocksAPI::getRulesReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}

// Fetch one rule.
void UNinjaBlocksAPI::getRule(const QString& ruleId)
{
    QNetworkReply* reply = getRequest(QString("rule/%1").arg(ruleId));
    connect(reply, SIGNAL(finished()), this, SLOT(getRuleReply()));
}

void UNinjaBlocksAPI::getRuleReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}

// Create a new rule.
void UNinjaBlocksAPI::postRule(const QString& shortName, const QString& preConditions, const QString& actions, const QString& timeout)
{
    QJsonObject obj;
    obj["shortName"] = shortName;
    obj["preconditions"] = preConditions;
    obj["actions"] = actions;
    if (timeout != NULL) obj["timeout"] = timeout;
    QJsonDocument doc(obj);

    QNetworkReply* reply = postRequest("rule", doc.toJson());
    connect(reply, SIGNAL(finished()), this, SLOT(postRuleReply()));
}

void UNinjaBlocksAPI::postRuleReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}

// Update a rule.
void UNinjaBlocksAPI::putRule(const QString& ruleId, const QString& shortName, const QString& preConditions, const QString& actions, const QString& timeout)
{
    QJsonObject obj;
    obj["shortName"] = shortName;
    obj["preconditions"] = preConditions;
    obj["actions"] = actions;
    if (timeout != NULL) obj["timeout"] = timeout;
    QJsonDocument doc(obj);

    QNetworkReply* reply = putRequest(QString("rule/%1").arg(ruleId), doc.toJson());
    connect(reply, SIGNAL(finished()), this, SLOT(putRuleReply()));
}

void UNinjaBlocksAPI::putRuleReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

}

// Delete a rule.
void UNinjaBlocksAPI::deleteRule(const QString& ruleId)
{
    QNetworkReply* reply = deleteRequest(QString("rule/%1").arg(ruleId));
    connect(reply, SIGNAL(finished()), this, SLOT(deleteRuleReply()));
}

void UNinjaBlocksAPI::deleteRuleReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}


// Suspend a rule.
void UNinjaBlocksAPI::suspendRule(const QString& ruleId)
{
    QNetworkReply* reply = postRequest(QString("rule/%1/suspend").arg(ruleId), NULL);
    connect(reply, SIGNAL(finished()), this, SLOT(suspendRuleReply()));
}

void UNinjaBlocksAPI::suspendRuleReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}

// Suspend a rule.
void UNinjaBlocksAPI::unsuspendRule(const QString& ruleId)
{
    QNetworkReply* reply = deleteRequest(QString("rule/%1/suspend").arg(ruleId));
    connect(reply, SIGNAL(finished()), this, SLOT(unsuspendRuleReply()));
}

void UNinjaBlocksAPI::unsuspendRuleReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        // emit networkError
    }

    QString data(reply->readAll());
    // TODO: Parse JSON reply into our class

    reply->deleteLater();
}

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
