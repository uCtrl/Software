#ifndef JSONSERIALIZABLE_H
#define JSONSERIALIZABLE_H

#include "Serialization/jsonreadable.h"
#include "Serialization/jsonwritable.h"

#include <QJsonDocument>
#include <QJsonArray>

class JsonSerializable : public JsonReadable, public JsonWritable
{
public:
    virtual void read(const QJsonObject &jsonObj) = 0;
    virtual void write(QJsonObject &jsonObj) const = 0;
};

#endif // JSONSERIALIZABLE_H
