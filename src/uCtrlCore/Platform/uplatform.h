#ifndef UPLATFORM_H
#define UPLATFORM_H

#include "Serialization/jsonserializable.h"
#include "Device/udevice.h"
#include "Communication/usocket.h"
#include <QObject>
#include <QAbstractListModel>

class UPlatform : public QAbstractListModel, public JsonSerializable
{
    Q_OBJECT

    Q_PROPERTY(QString name READ getName WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(int id READ getId WRITE setId)
    Q_PROPERTY(QString ip READ getIp WRITE setIp)
    Q_PROPERTY(int port READ getPort WRITE setPort)
    Q_PROPERTY(QString room READ getRoom WRITE setRoom NOTIFY roomChanged)
    Q_PROPERTY(QList<UDevice*> devices READ getDevices WRITE setDevices)

public:
    Q_INVOKABLE QObject* getDeviceAt(int index) const;

    UPlatform(QObject* parent);
    UPlatform(QObject* parent, const QString& ip, const int port);
    UPlatform(const UPlatform& platform);
    ~UPlatform();

    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual int rowCount(const QModelIndex &parent) const;

    int getId() const { return m_id; }
    QString getIp() const { return m_ip; }
    QString getName() const { return m_name; }
    int getPort() const { return m_port; }
    QList<UDevice*> getDevices() const { return m_devices; }
    QString getRoom() const { return m_room; }

    void read(const QJsonObject &jsonObj);
    void write(QJsonObject &jsonObj) const;

    void createSocket();

public slots:
    void setId(int arg) { m_id = arg; }
    void setIp(QString arg) { m_ip = arg; }
    void setPort(int arg) { m_port = arg; }
    void setDevices(QList<UDevice*> arg) { m_devices = arg; }
    void setName(QString arg) { m_name = arg; }
    void setRoom(QString arg) { m_room = arg; }

    void connected();
    void receivedRequest(QString message);

signals:
    void nameChanged(QString arg);
    void roomChanged(QString arg);

private:
    int m_id;
    QString m_ip;
    QString m_name;
    int m_port;
    QList<UDevice*> m_devices;
    QString m_room;
    USocket* m_socket;
};
#endif // UPLATFORM_H
