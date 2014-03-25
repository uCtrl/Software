#include "udevicemodel.h"

UDeviceModel::UDeviceModel(const UDevice* device, QObject *parent)
    : QAbstractListModel(parent)
    , m_device(device)
{
}


UDeviceModel::~UDeviceModel()
{
}

QString UDeviceModel::name() {
    QString string = m_device->getName();
    return string;
}

void UDeviceModel::setName(QString newName) {}

int UDeviceModel::id() {
    return this->id();
}

void UDeviceModel::setId(int newId) {}

int UDeviceModel::ip() {
    return m_device->getId();
}

void UDeviceModel::setIp(int newIp) {}

int UDeviceModel::type() {
    return m_device->getDeviceInfo()->getType();
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
    const UScenario* scenario = &m_device->getScenarios().at(0);
    return new UScenarioModel(scenario);
}

