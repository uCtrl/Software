#ifndef LISTITEM_H
#define LISTITEM_H

#include <QObject>
#include <QVariant>
#include <QString>
#include <QHash>

class ListItem : public QObject
{
    Q_OBJECT

public:
    ListItem(QObject *parent = 0) : QObject(parent) {}
    virtual ~ListItem() {}
    virtual QVariant data(int role) const = 0;
    virtual bool setData(const QVariant & value, int role) = 0;
    virtual QHash<int, QByteArray> roleNames() const = 0;

    // Base properties
    inline QString id() const { return m_id; }
    inline void id(const QString& id) { m_id = id; emit dataChanged(); }
    inline bool enabled() const { return m_enabled; }
    inline void enabled(bool enabled) { m_enabled = enabled; emit dataChanged(); }
    inline uint lastUpdated() const { return m_lastUpdated; }
    inline void lastUpdated(uint lastUpdated) { m_lastUpdated = lastUpdated; emit dataChanged(); }

signals:
    void dataChanged();

private:
    QString m_id;
    bool m_enabled;
    uint m_lastUpdated;
};

#endif // LISTITEM_H
