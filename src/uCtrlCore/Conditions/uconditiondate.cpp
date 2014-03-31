#include "uconditiondate.h"

UConditionDate::UConditionDate(QObject *parent, UConditionDate::UEConditionDateType type, QDate *beginDate, QDate *endDate)
    :UCondition(parent, UEConditionType::Date)
{
    setBeginDate(beginDate);
    setEndDate(endDate);
    setDateType(type);
}

UConditionDate::UConditionDate(QObject *parent)
    :UCondition(parent, UEConditionType::Date)
{
    int day = QDate::currentDate().day();
    int month = QDate::currentDate().month();
    int year = QDate::currentDate().year();
    setBeginDate    (new QDate(year, month, day));
    setEndDate      (new QDate(year, month, day));

    setDateType(UEConditionDateType::DDMMYYYY);
}

void UConditionDate::read(const QJsonObject &jsonObj)
{
    UCondition::read(jsonObj);

    QDate tmp = QDate::fromString(jsonObj["beginDate"].toString(), Qt::DateFormat::ISODate);
    int day =    tmp.day();
    int month =  tmp.month();
    int year =   tmp.year();
    setBeginDate    (new QDate(year, month, day));

    tmp = QDate::fromString(jsonObj["endDate"].toString(), Qt::DateFormat::ISODate);
    day =    tmp.day();
    month =  tmp.month();
    year =   tmp.year();
    setEndDate    (new QDate(year, month, day));
}

void UConditionDate::write(QJsonObject &jsonObj) const
{
    UCondition::write(jsonObj);
    jsonObj["beginDate"] = m_beginDate->toString(Qt::DateFormat::ISODate);
    jsonObj["endDate"] = m_endDate->toString(Qt::DateFormat::ISODate);
}

