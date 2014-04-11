#ifndef GETPLATFORMREQUEST_H
#define GETPLATFORMREQUEST_H

#include "urequest.h"

class GetPlatformRequest : public URequest
{
public:
    GetPlatformRequest();
    UEMessageType getMessageType() const { return m_messageType; }
    void write(QJsonObject& jsonObj) const;
};

#endif // GETPLATFORMREQUEST_H
