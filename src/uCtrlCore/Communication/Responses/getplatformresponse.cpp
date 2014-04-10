#include "getplatformresponse.h"
#include <QDebug>

GetPlatformResponse::GetPlatformResponse(UPlatform* platform)
{
    m_messageType = UEMessageType::GetPlatformResponse;
    m_platform = platform;
}


void GetPlatformResponse::read(const QJsonObject& jsonObj)
{
    if(!jsonObj["status"].toBool())
    {
        qDebug() << "Error in GetPlatformResponse::read() " << jsonObj["error"].toString();
        return;
    }

    m_platform->read(jsonObj["platform"].toObject());
}
