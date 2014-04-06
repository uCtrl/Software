#include "Utility/uniqueidgenerator.h"
#include "uplatform.h"

UPlatform::UPlatform(QObject* parent) : QAbstractListModel(parent)
{
    setId(UniqueIdGenerator::GenerateUniqueId());
}

UPlatform::UPlatform(QObject* parent, const QString& ip, const int port) : QAbstractListModel(parent)
{
    setIp(ip);
    setPort(port);
}

UPlatform::UPlatform(const UPlatform& platform)
{
    setId(platform.getId());
    setIp(platform.getIp());
    setPort(platform.getPort());
    setDevices(platform.getDevices());
}

UPlatform::~UPlatform()
{
    delete m_socket;
}

void UPlatform::createSocket()
{
    if(m_ip == NULL || m_port == 0)
        return;

    m_socket = new USocket(m_ip, m_port);
    connect(m_socket, SIGNAL(hostConnected()), this, SLOT(connected()));
    connect(m_socket, SIGNAL(received(QString)), this, SLOT(receivedRequest(QString)));
}

void UPlatform::connected()
{
    m_socket->write("getAllDevices");
}

void UPlatform::receivedRequest(QString message)
{
    qDebug() << "Received: " << message;
    JsonSerializer::parse(message, this);
}

void UPlatform::setEnabled(QString arg)
{
    if (m_enabled != arg) {
        m_enabled = arg;
        emit enabledChanged(arg);
    }
}

QObject* UPlatform::getDeviceAt(int index) const {
    if (index < 0 || index >= m_devices.count())
        return 0;

    return (QObject*) ( getDevices().at(index) );
}

QVariant UPlatform::data(const QModelIndex & index, int role) const {
    return QVariant();
}

int UPlatform::rowCount(const QModelIndex &parent) const
{
    return m_devices.count();
}

void UPlatform::read(const QJsonObject &jsonObj)
{
    this->setId(jsonObj["id"].toInt());
    //this->setIp(jsonObj["ip"].toString());
    //this->setPort(jsonObj["port"].toInt());
    this->setName(jsonObj["name"].toString());
    this->setRoom(jsonObj["room"].toString());
    this->setEnabled(jsonObj["enabled"].toString());

    QJsonArray devicesArray = jsonObj["devices"].toArray();
    foreach(QJsonValue deviceJson, devicesArray)
    {
        UDevice* d = new UDevice(this);
        d->read(deviceJson.toObject());
        this->m_devices.append(d);
    }
}

void UPlatform::write(QJsonObject &jsonObj) const
{
    jsonObj["id"] = getId();
    jsonObj["ip"] = getIp();
    jsonObj["port"] = getPort();
    jsonObj["enabled"] = getEnabled();
    jsonObj["name"] = getName();
    jsonObj["room"] = getRoom();

    QJsonArray devicesArray;
    foreach(UDevice* device, this->m_devices)
    {
        QJsonObject deviceJson;
        device->write(deviceJson);
        devicesArray.append(deviceJson);
    }

    jsonObj["devices"] = devicesArray;
}
