#include "saveplatformresponse.h"

SavePlatformResponse::SavePlatformResponse()
{
    m_messageType = UEMessageType::SavePlatformResponse;
}

void SavePlatformResponse::read(const QJsonObject& jsonObj)
{
    if(!jsonObj["status"].toBool())
    {
        qDebug() << "Error in GetPlatformResponse::read() " << jsonObj["error"].toString();
        return;
    }
}
