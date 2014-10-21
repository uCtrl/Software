#ifndef UPLATFORM_H
#define UPLATFORM_H

#include "Models/nestedlistitem.h"
#include "Models/nestedlistmodel.h"
#include "Device/udevicesmodel.h"

class UPlatform : public NestedListItem
{
    Q_OBJECT

    enum PlatformRoles
    {
        idRole = Qt::UserRole + 1,
        nameRole,
        firmwareVersionRole,
        ipRole,
        portRole,
        roomRole,
        statusRole,
        enabledRole,
        lastUpdatedRole,
    };

public:
    explicit UPlatform(QObject *parent = 0);
    ~UPlatform();

    // NestedListItem
    QVariant data(int role) const;
    bool setData(const QVariant &value, int role);
    QHash<int, QByteArray> roleNames() const;
    ListModel* nestedModel() const;

    // JsonSerializable
    void write(QJsonObject &jsonObj) const;
    void read(const QJsonObject &jsonObj);

    // Properties
    QString name() const;
    void name(const QString& name);
    QString firmwareVersion() const;
    void firmwareVersion(const QString& firmwareVersion);
    QString ip() const;
    void ip(const QString& ip);
    int port() const;
    void port(int port);
    QString room() const;
    void room(const QString& room);
    int status() const;
    void status(int status);

private:
    QString m_firmwareVersion;
    QString m_name;
    int m_port;
    QString m_room;
    QString m_ip;
    int m_status;
    NestedListModel* m_devices;
};

#endif // UPLATFORM_H
