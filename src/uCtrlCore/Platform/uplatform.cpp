#include "Utility/uniqueidgenerator.h"
#include "uplatform.h"
#include "System/usystem.h"
#include "sstream"

UPlatform::UPlatform(QObject* parent)
    :QAbstractListModel(parent)
{
    setId(UniqueIdGenerator::GenerateUniqueId());
}

UPlatform::~UPlatform()
{

}
UPlatform::UPlatform(const UPlatform& platform)
{
    setId(platform.getId());
    setIp(platform.getIp());
    setPort(platform.getPort());
    setDevices(platform.getDevices());
}

QVariant UPlatform::data(const QModelIndex & index, int role) const {
    return QVariant();
}

int UPlatform::rowCount(const QModelIndex &parent) const
{
    return 0;
}

void UPlatform::fillObject(json::Object &obj) const
{
    obj["id"] = getId();
    obj["ip"] = getIp().toStdString();
    obj["port"] = getPort();

    obj["devices_size"] = (int) getDevices().size();
    for (int i = 0; i < getDevices().size(); i++)
    {
        std::ostringstream oss;
        oss << "devices[" << i << "]";

        std::string key = oss.str();
        obj[key] = getDevices()[i]->ToObject();
    }
}

void UPlatform::fillMembers(const json::Object &obj)
{
    setId(obj["id"]);
    setIp(QString::fromStdString(obj["ip"].ToString()));
    setPort(obj["port"]);

    int m_devices_size = obj["devices_size"];
    for (int i = 0; i < m_devices_size; i++)
    {
        std::ostringstream oss;
        oss << "devices[" << i << "]";

        std::string key = oss.str();
        UDevice* device = new UDevice();
        device->deserialize(obj[key]);
        m_devices.push_back(device);
    }
}

