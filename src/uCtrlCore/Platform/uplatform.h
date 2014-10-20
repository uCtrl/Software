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
    inline QString name() const { return m_name; }
    inline void name(const QString& name) { m_name = name; emit dataChanged(); }
    inline QString firmwareVersion() const { return m_firmwareVersion; }
    inline void firmwareVersion(const QString& firmwareVersion) { m_firmwareVersion = firmwareVersion; emit dataChanged(); }
    inline QString ip() const { return m_ip; }
    inline void ip(const QString& ip) { m_ip = ip; emit dataChanged(); }
    inline int port() const{ return m_port; }
    inline void port(int port) { m_port = port; emit dataChanged(); }
    inline QString room() const { return m_room; }
    inline void room(const QString& room) { m_room = room; emit dataChanged(); }
    inline int status() const{ return m_status; }
    inline void status(int status) { m_status = status; emit dataChanged(); }

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
