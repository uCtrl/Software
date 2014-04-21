#include "saveplatformrequest.h"

SavePlatformRequest::SavePlatformRequest(UPlatform* platform)
{
    m_messageType = UEMessageType::SavePlatformRequest;
    m_platform = platform;
}

void SavePlatformRequest::write(QJsonObject& jsonObj) const
{
    jsonObj["messageType"] = static_cast<int>(this->getMessageType());

    QJsonObject platformObj;
    m_platform->write(platformObj);

    jsonObj["platform"] = platformObj;
}
