#ifndef SAVEPLATFORMREQUEST_H
#define SAVEPLATFORMREQUEST_H

#include "urequest.h"
#include "Platform/uplatform.h"

class SavePlatformRequest: public URequest
{
public:
    SavePlatformRequest(UPlatform* platform);
    UEMessageType getMessageType() const { return m_messageType; }
    void write(QJsonObject& jsonObj) const;
private:
    UPlatform* m_platform;
};

#endif // SAVEPLATFORMREQUEST_H
