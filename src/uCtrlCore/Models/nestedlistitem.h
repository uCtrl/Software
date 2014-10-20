#ifndef NESTEDLISTITEM_H
#define NESTEDLISTITEM_H

#include "listitem.h"
#include "listmodel.h"

class NestedListItem : public ListItem
{
    Q_OBJECT

public :
    NestedListItem(QObject* parent = 0) : ListItem(parent) {}
    virtual ~NestedListItem() {}
    virtual ListModel* nestedModel() const = 0;

    // JsonSerializable
    virtual void write(QJsonObject &jsonObj) const = 0;
    virtual void read(const QJsonObject &jsonObj) = 0;
};

#endif // NESTEDLISTITEM_H
