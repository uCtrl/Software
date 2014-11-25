#include "ucondition.h"

UCondition::UCondition(QObject* parent) : ListItem(parent)
{
}

UCondition::~UCondition()
{
}

QVariant UCondition::data(int role) const
{
    switch (role)
    {
    case idRole:
        return id();
    case typeRole:
        return (int)type();
    case comparisonTypeRole:
        return (int)comparisonType();
    case beginValueRole:
        return beginValue();
    case endValueRole:
        return endValue();
    case deviceIdRole:
        return deviceId();
    case enabledRole:
        return enabled();
    case lastUpdatedRole:
        return lastUpdated();
    default:
        return QVariant();
    }
}

bool UCondition::setData(const QVariant& value, int role)
{
    switch (role)
    {
    case idRole:
        id(value.toString());
        break;
    case typeRole:
        type((UEType)value.toInt());
        break;
    case comparisonTypeRole:
        comparisonType((UEComparisonType)value.toInt());
        break;
    case beginValueRole:
        beginValue(value.toString());
        break;
    case endValueRole:
        endValue(value.toString());
        break;
    case deviceIdRole:
        deviceId(value.toString());
        break;
    case enabledRole:
        enabled(value.toBool());
        break;
    case lastUpdatedRole:
        lastUpdated(value.toDouble());
        break;
    default:
        return false;
    }
    return true;
}

QHash<int, QByteArray> UCondition::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[idRole] = "id";
    roles[typeRole] = "type";
    roles[comparisonTypeRole] = "comparisonType";
    roles[beginValueRole] = "beginValue";
    roles[endValueRole] = "endValue";
    roles[deviceIdRole] = "deviceId";
    roles[enabledRole] = "isEnabled";
    roles[lastUpdatedRole] = "lastUpdated";

    return roles;
}

void UCondition::write(QJsonObject &jsonObj) const
{
    jsonObj["id"] = this->id();
    jsonObj["type"] = (int)this->type();
    jsonObj["comparisonType"] = (int)this->comparisonType();
    jsonObj["beginValue"] = this->beginValue();
    jsonObj["endValue"] = this->endValue();
    jsonObj["deviceId"] = this->deviceId();
    jsonObj["enabled"] = this->enabled();
    jsonObj["lastUpdated"] = this->lastUpdated();
}

void UCondition::read(const QJsonObject &jsonObj)
{
    this->id(jsonObj["id"].toString());
    this->type((UEType)jsonObj["type"].toInt());
    this->comparisonType((UEComparisonType)jsonObj["comparisonType"].toInt());
    this->beginValue(jsonObj["beginValue"].toString());
    this->endValue(jsonObj["endValue"].toString());
    this->deviceId(jsonObj["deviceId"].toString());
    this->enabled(jsonObj["enabled"].toBool());
    this->lastUpdated(jsonObj["lastUpdated"].toDouble());
}

UCondition::UEType UCondition::type() const
{
    return m_type;
}

void UCondition::type(UEType type)
{
    if (m_type != type) {
        m_type = type;
        emit dataChanged();
    }
}

UCondition::UEComparisonType UCondition::comparisonType() const
{
    return m_comparisonType;
}

void UCondition::comparisonType(UEComparisonType comparisonType)
{
    if (m_comparisonType != comparisonType) {
        m_comparisonType = comparisonType;
        emit dataChanged();
    }
}

QString UCondition::beginValue() const
{
    return m_beginValue;
}

void UCondition::beginValue(const QString &beginValue)
{
    if (m_beginValue != beginValue) {
        m_beginValue = beginValue;
        emit dataChanged();
    }
}

QString UCondition::endValue() const
{
    return m_endValue;
}

void UCondition::endValue(const QString &endValue)
{
    if (m_endValue != endValue) {
        m_endValue = endValue;
        emit dataChanged();
    }
}

QString UCondition::deviceId() const
{
    return m_deviceId;
}

void UCondition::deviceId(const QString &deviceId)
{
    if (m_deviceId != deviceId) {
        m_deviceId = deviceId;
        emit dataChanged();
    }
}
