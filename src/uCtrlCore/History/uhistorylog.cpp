#include "uhistorylog.h"

UHistoryLog::UHistoryLog(QObject* parent) : ListItem(parent)
{

}

UHistoryLog::UHistoryLog(UELogType t, UESeverity s, QString m, QDateTime d, QObject* parent) : ListItem(parent)
{
    type(t);
    severity(s);
    message(m);
    timestamp(d);
}

UHistoryLog::~UHistoryLog()
{
}

QVariant UHistoryLog::data(int role) const
{
    switch (role)
    {
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
        timestamp(QDateTime::fromTime_t((uint)value.toInt()));
        break;
    default:
        return false;
    }
    return true;
}

QHash<int, QByteArray> UHistoryLog::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[typeRole] = "type";
    roles[severityRole] = "severity";
    roles[messageRole] = "message";
    roles[timestampRole] = "timestamp";

    return roles;
}

void UHistoryLog::write(QJsonObject& jsonObj) const
{
    jsonObj["type"] = (int)m_type;
    jsonObj["severity"] = (int)m_severity;
    jsonObj["message"] = m_message;
    jsonObj["timestamp"] = (int)m_timestamp.toTime_t();
}

void UHistoryLog::read(const QJsonObject &jsonObj)
{
    this->type((UELogType)jsonObj["type"].toInt());
    this->severity((UESeverity)jsonObj["severity"].toInt());
    this->message(jsonObj["message"].toString());
    this->timestamp(QDateTime::fromTime_t((uint)jsonObj["timestamp"].toInt()));
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

void UHistoryLog::message(const QString &message)
{
    if (m_message != message) {
        m_message = message;
        emit dataChanged();
    }
}

QString UHistoryLog::timestamp() const
{
    QDateTime today = QDateTime::currentDateTime();
    long numberOfDays = m_timestamp.daysTo(today);

    if(numberOfDays == 0)
    {
        return m_timestamp.time().toString("hh:mm");
    }
    if(numberOfDays == 1)
    {
        return "Yesterday " + m_timestamp.time().toString("hh:mm");
    }
    if(numberOfDays >= 2 && numberOfDays < 7)
    {
        return numberOfDays + " days ago";
    }
    if(numberOfDays >= 7 && numberOfDays < 31)
    {
        return (numberOfDays/7) + " weeks ago";
    }
    return m_timestamp.toString("dd/MM/yyyy hh:mm");
}

void UHistoryLog::timestamp(const QDateTime &timestamp)
{
    if (m_timestamp != timestamp) {
        m_timestamp = timestamp;
        emit dataChanged();
    }
}
