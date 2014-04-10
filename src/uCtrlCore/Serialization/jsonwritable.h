#ifndef JSONWRITABLE_H
#define JSONWRITABLE_H

#include <QJsonObject>

class JsonWritable
{
public:
    virtual void write(QJsonObject &jsonObj) const = 0;
};
#endif // JSONWRITABLE_H
