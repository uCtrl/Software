#include "uninjablocksapi.h"

UNinjaBlocksAPI::UNinjaBlocksAPI(QNetworkAccessManager* nam, QObject *parent) :
    QObject(parent)
{
    m_networkAccessManager = nam;

    QObject::connect(m_networkAccessManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(parseResponse(QNetworkReply*)));
}


//##### User #####

// Return information about the authenticated user
void UNinjaBlocksAPI::getUser()
{
    sendRequest("user");
}

// Returns the 30 most recent entries in the authenticating user's activity stream
void UNinjaBlocksAPI::getUserStream()
{
    sendRequest("user/stream");
}

// Returns user's pusher channel key
void UNinjaBlocksAPI::getUserPushercahnnel()
{
    sendRequest("user/pusherchannel");
}




//##### Block #####

// Fetch all claimed blocks
void UNinjaBlocksAPI::getBlocks()
{
    sendRequest("block");
}

// Fetch a specific block's details
void UNinjaBlocksAPI::getBlockDetails(const QString &blockId)
{
    sendRequest("blockblock/" + blockId);
}




//#### Devices ####

// Returns the list of devices associated with the authenticating user
void UNinjaBlocksAPI::getDevices()
{
    sendRequest("devices");
}

// Fetch metadata about the specified device
void UNinjaBlocksAPI::getDeviceDetails(const QString &deviceGuid)
{
    sendRequest("device/" + deviceGuid);
}

// Return the last heartbeat for the specified device.

void UNinjaBlocksAPI::getDeviceHeartbeat(const QString &deviceGuid)
{
    sendRequest("device/" + deviceGuid + "/" + "heartbeat");
}



void UNinjaBlocksAPI::getRules()
{
}



void UNinjaBlocksAPI::sendRequest(const QString &urlString)
{

    QUrl url(NinjaBaseUrl + urlString);
    QUrlQuery urlQuery;
    urlQuery.addQueryItem("user_access_token", UserAccessToken);
    url.setQuery(urlQuery);
    QNetworkRequest req(url);
    m_networkAccessManager->get(req);
}


void UNinjaBlocksAPI::parseResponse(QNetworkReply* reply)
{
    if (reply->error() != QNetworkReply::NoError) {
        // A communication error has occurred
        //emit networkError(reply->error());
        return;
    }

    QByteArray data = reply->readAll();
}
