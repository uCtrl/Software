#ifndef JSONSERIALIZER_H
#define JSONSERIALIZER_H

#include "Serialization/jsonserializable.h"
#include <QJsonDocument>

class JsonSerializer
{
public:
   static QByteArray serialize(JsonWritable* obj);
   static void parse(const QByteArray& json, JsonReadable* jsonSerializable);
};
#endif // JSONSERIALIZER_H
