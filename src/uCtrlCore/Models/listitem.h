#ifndef LISTITEM_H
#define LISTITEM_H

#include <QObject>
#include <QVariant>
#include <QString>
#include <QHash>
#include <QDateTime>

#include "Serialization/jsonserializable.h"

class ListItem : public QObject, public JsonSerializable
{
    Q_OBJECT

public:
    ListItem(QObject *parent = 0);
    virtual ~ListItem();
    virtual QVariant data(int role) const = 0;
    virtual bool setData(const QVariant & value, int role) = 0;
    virtual QHash<int, QByteArray> roleNames() const = 0;

    // JsonSerializable
    virtual void write(QJsonObject &jsonObj) const = 0;
    virtual void read(const QJsonObject &jsonObj) = 0;

    // Base properties
    Q_INVOKABLE QString id() const;
    void id(const QString& id);
    bool enabled() const;
    void enabled(bool enabled);
    double lastUpdated() const;
    void lastUpdated(double lastUpdated);

signals:
    void dataChanged();

public slots:
    void updateTimestamp();

protected:
    QString m_id;
    bool m_enabled;
    double m_lastUpdated;
};

#endif // LISTITEM_H
