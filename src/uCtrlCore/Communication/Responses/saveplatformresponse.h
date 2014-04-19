#ifndef SAVEPLATFORMRESPONSE_H
#define SAVEPLATFORMRESPONSE_H

#include "uresponse.h"
#include "QDebug"

class SavePlatformResponse: public UResponse
{
public:
    SavePlatformResponse();
    UEMessageType getMessageType() const { return m_messageType; }
    void read(const QJsonObject& jsonObj);
};

#endif // SAVEPLATFORMRESPONSE_H
