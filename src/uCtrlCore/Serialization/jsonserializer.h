#ifndef JSONSERIALIZER_H
#define JSONSERIALIZER_H

#include "Serialization/jsonserializable.h"
#include <QJsonDocument>

class JsonSerializer
{
public:
   static QString serialize(JsonSerializable *obj);
   static void parse(const QString &json, JsonSerializable *jsonSerializable);
};
#endif // JSONSERIALIZER_H
