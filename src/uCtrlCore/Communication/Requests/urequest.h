#ifndef REQUEST_H
#define REQUEST_H

#include "Communication/uemessagetype.h"
#include <Serialization/jsonwritable.h>

class URequest : public JsonWritable
{
public:
    virtual UEMessageType getMessageType() const = 0;
    virtual void write(QJsonObject &jsonObj) const = 0;

protected:
    UEMessageType m_messageType;
};

#endif // REQUEST_H
