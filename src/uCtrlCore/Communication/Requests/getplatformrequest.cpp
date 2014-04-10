#include "getplatformrequest.h"

GetPlatformRequest::GetPlatformRequest()
{
    m_messageType = UEMessageType::GetPlatformRequest;
}

void GetPlatformRequest::write(QJsonObject& jsonObj) const
{
    jsonObj["messageType"] = static_cast<int>(this->getMessageType());
}
