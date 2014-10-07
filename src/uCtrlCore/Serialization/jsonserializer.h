#ifndef JSONSERIALIZER_H
#define JSONSERIALIZER_H

#include "Serialization/jsonserializable.h"
#include <QJsonDocument>

class JsonSerializer
{
public:
   static QByteArray serialize(JsonWritable* obj);
   static void parse(const QString& json, JsonReadable* jsonSerializable);
};
#endif // JSONSERIALIZER_H
