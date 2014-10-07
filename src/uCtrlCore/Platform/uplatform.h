#ifndef UPLATFORM_H
#define UPLATFORM_H

#include "Serialization/jsonserializable.h"
#include "Device/udevice.h"
#include <QObject>
#include <QAbstractListModel>

class UPlatform : public QAbstractListModel, public JsonSerializable
{
    Q_OBJECT

    Q_PROPERTY(QString name READ getName WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString id READ getId WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString ip READ getIp WRITE setIp NOTIFY ipChanged)
    Q_PROPERTY(int port READ getPort WRITE setPort NOTIFY portChanged)
    Q_PROPERTY(QString room READ getRoom WRITE setRoom NOTIFY roomChanged)
    Q_PROPERTY(QList<UDevice*> devices READ getDevices WRITE setDevices)
    Q_PROPERTY(bool enabled READ getEnabled WRITE setEnabled NOTIFY enabledChanged)
    Q_PROPERTY(QString firmwareVersion READ getFirmwareVersion WRITE setFirmwareVersion)
    Q_PROPERTY(QDateTime lastUpdate READ getLastUpdate NOTIFY updateChanged)

public:
    UPlatform() {}
    UPlatform(QObject* parent);
    UPlatform(QObject* parent, const QString& id);
    UPlatform(QObject* parent, const QString& ip, const int port);
    UPlatform(const UPlatform& platform);
    ~UPlatform();

    QString getId() const
    {
        return m_id;
    }

    QString getIp() const
    {
        return m_ip;
    }

    QString getName() const
    {
        return m_name;
    }

    int getPort() const
    {
        return m_port;
    }

    QList<UDevice*> getDevices() const
    {
        return m_devices;
    }

    QString getRoom() const
    {
        return m_room;
    }

    bool getEnabled() const
    {
        return m_enabled;
    }

    QString getFirmwareVersion() const
    {
        return m_firmwareVersion;
    }

    Q_INVOKABLE QObject* getDeviceAt(int index) const;
    QDateTime       getLastUpdate() const;
    Q_INVOKABLE void addDevice(UDevice* device);
    Q_INVOKABLE void deleteDevice(const QString& id);
    Q_INVOKABLE bool containsDevice(const QString& id);
    Q_INVOKABLE UDevice* findDevice(const QString& id);
    void copyProperties(UPlatform* platform);

    // QAbstractListModel
    virtual QVariant data(const QModelIndex &index, int role) const
    {
        return QVariant();
    }
    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const
    {
        return m_devices.count();
    }

    // JsonSerializable
    void read(const QJsonObject &jsonObj);
    void write(QJsonObject &jsonObj) const;

public slots:
    void setId(QString arg)
    {
        m_id = arg;
    }

    void setIp(QString arg)
    {
        m_ip = arg;
    }

    void setPort(int arg)
    {
        m_port = arg;
    }

    void setDevices(QList<UDevice*> arg)
    {
        m_devices = arg;
    }

    void setName(QString arg)
    {
        m_name = arg;
    }

    void setRoom(QString arg)
    {
        m_room = arg;
    }

    void setEnabled(bool arg)
    {
        if (m_enabled != arg) {
            m_enabled = arg;
            emit enabledChanged(arg);
        }
    }

    void setFirmwareVersion(QString arg)
    {
        m_firmwareVersion = arg;
    }

    void save();

signals:
    void nameChanged(QString arg);
    void roomChanged(QString arg);
    void idChanged(QString arg);
    void ipChanged(QString arg);
    void portChanged(int arg);
    void enabledChanged(bool arg);
    void updateChanged(QDateTime arg);
    void savePlatform();
    void devicesChanged(QList<UDevice*> arg);

private:
    QString m_id;
    QString m_ip;
    QString m_name;
    int m_port;
    QList<UDevice*> m_devices;
    QString m_room;
    bool m_enabled;
    QString m_firmwareVersion;
};
#endif // UPLATFORM_H
