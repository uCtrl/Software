#ifndef UPLATFORMSMODEL_H
#define UPLATFORMSMODEL_H

#include "Models/nestedlistmodel.h"
#include "uplatform.h"

class UPlatformsModel : public NestedListModel
{
    Q_OBJECT

public:
    explicit UPlatformsModel(QObject* parent = 0);

    Q_INVOKABLE void asd() {
        int i = 0;
        i++;
    }

    // JsonSerializable
    void write(QJsonObject &jsonObj) const;
    void read(const QJsonObject &jsonObj);
};

#endif // UPLATFORMSMODEL_H
