#ifndef JSONREADABLE_H
#define JSONREADABLE_H

#include <QJsonObject>

class JsonReadable
{
public:
    virtual void read(const QJsonObject &jsonObj) = 0;
};
#endif // JSONREADABLE_H
