#include "jsonserializer.h"

QByteArray JsonSerializer::serialize(JsonWritable* obj)
{
    QJsonObject jsonObj;
    obj->write(jsonObj);
    QJsonDocument doc(jsonObj);
    return doc.toJson(QJsonDocument::Indented);
}

void JsonSerializer::parse(const QByteArray& json, JsonReadable* jsonSerializable)
{
    QJsonDocument document = QJsonDocument::fromJson(json);
    QJsonObject jsonObj = document.object();
    jsonSerializable->read(jsonObj);
}
