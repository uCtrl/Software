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
    virtual QString id() const = 0;
    virtual QVariant data(int role) const = 0;
    virtual bool setData(const QVariant & value, int role) = 0;
    virtual QHash<int, QByteArray> roleNames() const = 0;
signals:
    void dataChanged();
};

#endif // LISTITEM_H
