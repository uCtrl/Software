#ifndef NESTEDLISTMODEL_H
#define NESTEDLISTMODEL_H

#include "listmodel.h"
#include "nestedlistitem.h"

class NestedListModel : public ListModel
{
    Q_OBJECT

public:
    explicit NestedListModel(NestedListItem* prototype, QObject* parent = 0);

    Q_INVOKABLE QObject* nestedModelFromId(const QString& id);

    // JsonSerializable
    virtual void write(QJsonObject &jsonObj) const = 0;
    virtual void read(const QJsonObject &jsonObj) = 0;
};

#endif // NESTEDLISTMODEL_H
