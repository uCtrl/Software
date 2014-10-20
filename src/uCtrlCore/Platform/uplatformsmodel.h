#ifndef UPLATFORMSMODEL_H
#define UPLATFORMSMODEL_H

#include "Models/nestedlistmodel.h"
#include "uplatform.h"

class UPlatformsModel : public NestedListModel
{
public:
    UPlatformsModel(QObject* parent = 0);

    // JsonSerializable
    void write(QJsonObject &jsonObj) const;
    void read(const QJsonObject &jsonObj);
};

#endif // UPLATFORMSMODEL_H
