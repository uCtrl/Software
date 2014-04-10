#ifndef RESPONSE_H
#define RESPONSE_H

#include "Communication/uemessagetype.h"
#include <Serialization/jsonreadable.h>

class UResponse : public JsonReadable
{
public:
    virtual UEMessageType getMessageType() const = 0;
    virtual void read(const QJsonObject &jsonObj) = 0;

protected:
    UEMessageType m_messageType;
};

#endif // RESPONSE_H
