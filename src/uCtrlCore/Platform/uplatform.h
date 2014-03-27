#ifndef UPLATFORM_H
#define UPLATFORM_H

#include "Serialization/jsonserializable.h"
#include "Device/udevice.h"
#include <QAbstractListModel>

class UPlatform : public QAbstractListModel, public JsonSerializable
{
    Q_OBJECT

    Q_PROPERTY(QList<UDevice*> devices READ getDevices WRITE setDevices)
    Q_PROPERTY(int id READ getId WRITE setId)
    Q_PROPERTY(QString ip READ getIp WRITE setIp)
    Q_PROPERTY(int port READ getPort WRITE setPort)

public:
    UPlatform(QObject* parent);
    UPlatform(QObject* parent, const QString& ip, const int port);
    UPlatform(const UPlatform& platform);
    ~UPlatform();

    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual int rowCount(const QModelIndex &parent) const;

    int getId() const { return m_id; }
    QString getIp() const { return m_ip; }
    int getPort() const { return m_port; }
    QList<UDevice*> getDevices() const { return m_devices; }

    void read(const QJsonObject &jsonObj);
    void write(QJsonObject &jsonObj) const;

public slots:
    void setId(int arg) { m_id = arg; }
    void setIp(QString arg) { m_ip = arg; }
    void setPort(int arg) { m_port = arg; }
    void setDevices(QList<UDevice*> arg) { m_devices = arg; }

private:
    int m_id;
    QString m_ip;
    int m_port;
    QList<UDevice*> m_devices;
};
#endif // UPLATFORM_H
