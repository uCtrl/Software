#include "uninjablocksapi.h"

UNinjaBlocksAPI::UNinjaBlocksAPI(QNetworkAccessManager* nam, QObject *parent) :
    QObject(parent)
{
    m_networkAccessManager = nam;

    QObject::connect(m_networkAccessManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(parseResponse(QNetworkReply*)));
}

void UNinjaBlocksAPI::getBlocks()
{
    sendRequest("block");
}

void UNinjaBlocksAPI::getBlock(const QString &blockId)
{
}

void UNinjaBlocksAPI::getDevices()
{
}

void UNinjaBlocksAPI::getDevice(const QString &deviceId)
{
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
