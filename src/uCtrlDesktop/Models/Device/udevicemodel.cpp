#include "udevicemodel.h"

UDeviceModel::UDeviceModel(const UDeviceBuilder* deviceBuilder, QObject *parent)
    : QAbstractListModel(parent)
    , m_deviceBuider(deviceBuilder)
    , m_device(deviceBuilder->getDevice())
{
}

UDeviceModel::~UDeviceModel()
{
}

QString UDeviceModel::name() {
    QString string = QString::fromStdString(m_device->m_name);
    return string;
}

void UDeviceModel::setName(QString newName) {}

int UDeviceModel::id() {
    return m_device->m_deviceInfo->m_deviceSummary->m_id;
}

void UDeviceModel::setId(int newId) {}

int UDeviceModel::ip() {
    return m_device->m_deviceInfo->m_deviceSummary->m_ip;
}

void UDeviceModel::setIp(int newIp) {}

int UDeviceModel::type() {
    return m_device->m_deviceInfo->m_type;
}

void UDeviceModel::setType(int newType) {}

int UDeviceModel::rowCount(const QModelIndex & parent) const {
    return 0;
}

QVariant UDeviceModel::data(const QModelIndex & index, int role) const { 

    return QVariant();
}

QHash<int, QByteArray> UDeviceModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[0] = "name";
    roles[1] = "id";
    roles[2] = "ip";
    roles[3] = "type";

    return roles;
}

QObject* UDeviceModel::getScenario() const
{
    const UScenario* scenario = &m_device->scenarios().at(0);
    return new UScenarioModel(scenario);
}

