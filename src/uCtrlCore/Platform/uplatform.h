#ifndef UPLATFORM_H
#define UPLATFORM_H

#include "Serialization/JsonMacros.h"
#include "Device/udevice.h"
#include <QList>
#include <QAbstractListModel>

class UPlatform: public QAbstractListModel
{
    Q_PROPERTY(QList<UDevice*> devices READ getDevices WRITE setDevices)
    Q_PROPERTY(int id READ getId WRITE setId)
    Q_PROPERTY(QString ip READ getIp WRITE setIp)
    Q_PROPERTY(int port READ getPort WRITE setPort)
    UCTRL_JSON(UPlatform)
public:
    UPlatform(QObject* parent = 0);
    UPlatform(const UPlatform& platform);

    ~UPlatform();

    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual int rowCount(const QModelIndex &parent) const;
    int getPort() const { return m_port; }
    QString getIp() const { return m_ip; }
    int getId() const { return m_id; }
    QList<UDevice*> getDevices() const { return m_devices; }

public slots:
    void setPort(int arg) { m_port = arg; }
    void setIp(QString arg) { m_ip = arg; }
    void setId(int arg) { m_id = arg; }
    void setDevices(QList<UDevice*> arg) { m_devices = arg; }

private:
    int m_port;
    QString m_ip;
    int m_id;
    QList<UDevice*> m_devices;
};

#endif // UPLATFORM_H
