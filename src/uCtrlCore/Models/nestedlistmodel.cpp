#include "nestedlistmodel.h"

NestedListModel::NestedListModel(NestedListItem *prototype, QObject *parent) : ListModel(prototype, parent)
{
}

QObject* NestedListModel::nestedModelFromId(const QString& id)
{
    NestedListItem* item = (NestedListItem*)find(id);
    if (item != NULL)
        return (QObject*) item->nestedModel();
    return NULL;
}
