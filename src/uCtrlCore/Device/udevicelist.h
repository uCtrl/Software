#ifndef UDEVICELIST_H
#define UDEVICELIST_H

#include <QAbstractListModel>
#include "udevice.h"

class UDeviceList : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(QList<UDevice*> devices READ getDevices WRITE setDevices NOTIFY devicesChanged)

public:
    UDeviceList(QObject *parent = 0);

    virtual QVariant data(const QModelIndex &index, int role) const { return QVariant();}
    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const { return m_devices.count();}

    QList<UDevice*> getDevices() const { return m_devices; }
    Q_INVOKABLE QObject* getDeviceAt(int index) { return m_devices.at(index); }
    Q_INVOKABLE int getDeviceCount() { return m_devices.count(); }

signals:
    void devicesChanged(QList<UDevice*> arg);

public slots:
    void setDevices(QList<UDevice*> arg)
    {
        if (m_devices != arg) {
            m_devices = arg;
            emit devicesChanged(arg);
        }
    }

private:
    QList<UDevice*> m_devices;
};

#endif // UDEVICELIST_H
