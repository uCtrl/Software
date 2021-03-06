#include "listitem.h"

ListItem::ListItem(QObject *parent) : QObject(parent)
{
    connect(this, SIGNAL(dataChanged()), this, SLOT(updateTimestamp()));
}

ListItem::~ListItem()
{
    disconnect(this, SIGNAL(dataChanged()), this, SLOT(updateTimestamp()));
}

QString ListItem::id() const
{
    return m_id;
}

void ListItem::id(const QString &id)
{
    if (m_id != id) {
        m_id = id;
        emit dataChanged();
    }
}

double ListItem::lastUpdated() const
{
    return m_lastUpdated;
}

void ListItem::lastUpdated(double lastUpdated)
{
    if (m_lastUpdated != lastUpdated) {
        m_lastUpdated = lastUpdated;
        emit dataChanged();
    }
}

void ListItem::updateTimestamp()
{
    this->lastUpdated(QDateTime::currentDateTimeUtc().toTime_t());
}
