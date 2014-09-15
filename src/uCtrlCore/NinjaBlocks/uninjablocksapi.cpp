#include "uninjablocksapi.h"

UNinjaBlocksAPI::UNinjaBlocksAPI(QNetworkAccessManager* nam, QObject *parent) :
    QObject(parent)
{
    m_networkAccessManager = nam;
}
