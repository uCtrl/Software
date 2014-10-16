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
};

#endif // NESTEDLISTMODEL_H
