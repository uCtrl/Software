#include "jsonserializer.h"
#include <QDebug>

QString JsonSerializer::serialize(JsonSerializable *obj)
{
    QJsonObject jsonObj;
    obj->write(jsonObj);
    QJsonDocument doc(jsonObj);
    QString result(doc.toJson(QJsonDocument::Indented));
    return result;
}

void JsonSerializer::parse(const QString &json, JsonSerializable *jsonSerializable)
{
    QJsonDocument document = QJsonDocument::fromJson(json.toUtf8());
    QJsonObject jsonObj = document.object();
    jsonSerializable->read(jsonObj);
}
