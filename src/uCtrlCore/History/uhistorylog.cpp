#include "uhistorylog.h"

uhistorylog::UDevice(QObject* parent) : NestedListItem(parent)
{

}

uhistorylog::~UDevice()
{
}

void uhistorylog::write(QJsonObject& jsonObj) const
{
    jsonObj["type"] = m_type;
    jsonObj["message"] = m_message;
    jsonObj["timestamp"] = m_timestamp.toTime_t();
}

void uhistorylog::read(const QJsonObject &jsonObj)
{
    this->type((UELogType)jsonObj["type"]);
    this->message(jsonObj["message"].toString());
    this->timestamp(QDateTime::fromTime_t((uint)jsonObj["timestamp"].toInt()));
}

QString uhistorylog::type() const
{
    return m_type.toString();
}

void uhistorylog::type(const UELogType& type)
{
    if (m_type != type) {
        m_type = type;
        emit dataChanged();
    }
}

QString uhistorylog::message() const
{
    return m_description;
}

void uhistorylog::message(const QString &message)
{
    if (m_message != message) {
        m_message = message;
        emit dataChanged();
    }
}

QString uhistorylog::timestamp() const
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

void uhistorylog::timestamp(const QDateTime &timestamp)
{
    if (m_timestamp != timestamp) {
        m_timestamp = timestamp;
        emit dataChanged();
    }
}
