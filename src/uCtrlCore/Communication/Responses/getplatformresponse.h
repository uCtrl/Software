#ifndef GETPLATFORMRESPONSE_H
#define GETPLATFORMRESPONSE_H

#include "uresponse.h"
#include "Platform/uplatform.h"

class GetPlatformResponse: public UResponse
{
public:
    GetPlatformResponse(UPlatform* platform);
    UEMessageType getMessageType() const { return m_messageType; }
    void read(const QJsonObject& jsonObj);

private:
    UPlatform* m_platform;
};

#endif // GETPLATFORMRESPONSE_H
