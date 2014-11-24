#include "ustatistic.h"

UStatistic::UStatistic(QObject *parent) : ListItem(parent)
{
}

UStatistic::~UStatistic()
{
}

QVariant UStatistic::data(int role) const
{
    switch (role)
    {
    case idRole:
        return id();
    case dataRole:
        return data();
    case typeRole:
        return type();
    case timestampRole:
        return timestamp();
    default:
        return QVariant();
    }
}

bool UStatistic::setData(const QVariant &value, int role)
{
    switch (role)
    {
    case idRole:
        id(value.toString());
        break;
    case dataRole:
        data(value.toString());
        break;
    case typeRole:
        type(value.toInt());
        break;
    case timestampRole:
        timestamp(value.toUInt());
        break;
    default:
        return false;
    }
    return true;
}

QHash<int, QByteArray> UStatistic::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[idRole] = "id";
    roles[dataRole] = "data";
    roles[typeRole] = "type";
    roles[timestampRole] = "timestamp";

    return roles;
}

void UStatistic::write(QJsonObject &jsonObj) const
{
    jsonObj["id"] = this->id();
    jsonObj["data"] = this->data();
    jsonObj["type"] = this->type();
    jsonObj["timestamp"] = QString::number(this->timestamp());
}

void UStatistic::read(const QJsonObject &jsonObj)
{
    this->id(jsonObj["id"].toString());
    this->data(jsonObj["data"].toString());
    this->type(jsonObj["type"].toInt());
    this->timestamp(jsonObj["timestamp"].toString().toUInt());
}

QString UStatistic::data() const
{
    return m_data;
}

void UStatistic::data(const QString &data)
{
    if (m_data != data) {
        m_data = data;
        emit dataChanged();
    }
}

int UStatistic::type() const
{
    return m_type;
}

void UStatistic::type(int type)
{
    if (m_type != type) {
        m_type = type;
        emit dataChanged();
    }
}

uint UStatistic::timestamp() const
{
    return m_timestamp;
}

void UStatistic::timestamp(uint timestamp)
{
    if (m_timestamp != timestamp) {
        m_timestamp = timestamp;
        emit dataChanged();
    }
}
