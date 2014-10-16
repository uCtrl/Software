#ifndef UPLATFORM_H
#define UPLATFORM_H

#include "Models/nestedlistitem.h"
#include "Models/nestedlistmodel.h"
#include "Device/udevice.h"

class UPlatform : public NestedListItem
{
    Q_OBJECT

    enum PlatformRoles
    {
        idRole = Qt::UserRole + 1,
        firmwareVersionRole,
        nameRole,
        portRole,
        roomRole,
        enabledRole,
        ipRole
    };

public:
    explicit UPlatform(QObject *parent = 0);
    ~UPlatform();

    // NestedListItem
    QVariant data(int role) const;
    bool setData(const QVariant &value, int role);
    QHash<int, QByteArray> roleNames() const;
    ListModel* nestedModel() const;

    // Properties
    inline QString id() const { return m_id; }
    inline void id(const QString& id) { m_id = id; emit dataChanged(); }
    inline QString firmwareVersion() const { return m_firmwareVersion; }
    inline void firmwareVersion(const QString& firmwareVersion) { m_firmwareVersion = firmwareVersion; emit dataChanged(); }
    inline QString name() const { return m_name; }
    inline void name(const QString& name) { m_name = name; emit dataChanged(); }
    inline int port() const{ return m_port; }
    inline void port(int port) { m_port = port; emit dataChanged(); }
    inline QString room() const { return m_room; }
    inline void room(const QString& room) { m_room = room; emit dataChanged(); }
    inline bool enabled() const { return m_enabled; }
    inline void enabled(bool enabled) { m_enabled = enabled; emit dataChanged(); }
    inline QString ip() const { return m_ip; }
    inline void ip(const QString& ip) { m_ip = ip; emit dataChanged(); }

private:
    QString m_id;
    QString m_firmwareVersion;
    QString m_name;
    int m_port;
    QString m_room;
    bool m_enabled;
    QString m_ip;
    NestedListModel* m_devices;
};

#endif // UPLATFORM_H
