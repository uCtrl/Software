#include "uhistorylog.h"

UHistoryLog::UHistoryLog(QObject* parent) : ListItem(parent)
{
}

UHistoryLog::~UHistoryLog()
{
}

QVariant UHistoryLog::data(int role) const
{
    switch (role)
    {
    case idRole:
        return id();
    case typeRole:
        return (int)type();
    case severityRole:
        return (int)severity();
    case messageRole:
        return message();
    case timestampRole:
        return timestamp();
    default:
        return QVariant();
    }
}

bool UHistoryLog::setData(const QVariant& value, int role)
{
    switch (role)
    {
    case idRole:
        id(value.toString());
        break;
    case typeRole:
        type((UELogType)value.toInt());
        break;
    case severityRole:
        severity((UESeverity)value.toInt());
        break;
    case messageRole:
        message(value.toString());
        break;
    case timestampRole:
        timestamp(value.toDouble());
        break;
    default:
        return false;
    }
    return true;
}

QHash<int, QByteArray> UHistoryLog::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[idRole] = "id";
    roles[typeRole] = "type";
    roles[severityRole] = "severity";
    roles[messageRole] = "message";
    roles[timestampRole] = "timestamp";

    return roles;
}

void UHistoryLog::write(QJsonObject& jsonObj) const
{
    jsonObj["id"] = m_id;
    jsonObj["type"] = (int)m_type;
    jsonObj["severity"] = (int)m_severity;
    jsonObj["message"] = m_message;
    jsonObj["timestamp"] = m_timestamp;
}

void UHistoryLog::read(const QJsonObject &jsonObj)
{
    this->id(jsonObj["id"].toString());
    this->type((UELogType)jsonObj["type"].toInt());
    this->severity((UESeverity)jsonObj["severity"].toInt());
    this->message(jsonObj["message"].toString());
    this->timestamp(jsonObj["timestamp"].toDouble());
}

UHistoryLog::UELogType UHistoryLog::type() const
{
    return m_type;
}

void UHistoryLog::type(const UELogType& type)
{
    if (m_type != type) {
        m_type = type;
        emit dataChanged();
    }
}

UHistoryLog::UESeverity UHistoryLog::severity() const
{
    return m_severity;
}

void UHistoryLog::severity(const UESeverity& severity)
{
    if (m_severity != severity) {
        m_severity = severity;
        emit dataChanged();
    }
}

QString UHistoryLog::message() const
{
    return m_message;
}

void UHistoryLog::message(const QString& message)
{
    if (m_message != message) {
        m_message = message;
        emit dataChanged();
    }
}

double UHistoryLog::timestamp() const
{
    return m_timestamp;
}

void UHistoryLog::timestamp(double timestamp)
{
    if (m_timestamp != timestamp) {
        m_timestamp = timestamp;
        emit dataChanged();
    }
}
