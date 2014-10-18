#include "listitem.h"

ListItem::ListItem(QObject *parent) : QObject(parent)
{
    connect(this, SIGNAL(dataChanged()), this, SLOT(updateTimestamp()));
}

ListItem::~ListItem()
{
    disconnect(this, SIGNAL(dataChanged()), this, SLOT(updateTimestamp()));
}

void ListItem::updateTimestamp()
{
    this->lastUpdated(QDateTime::currentDateTimeUtc().toTime_t());
}
