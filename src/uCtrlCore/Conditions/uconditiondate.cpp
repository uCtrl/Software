#include "uconditiondate.h"

UConditionDate::UConditionDate(QObject *parent, UConditionDate::UEConditionDateType type, QDate beginDate, QDate endDate)
    :UCondition(parent, UEConditionType::Date)
{
    setBeginDate(beginDate);
    setEndDate(endDate);
    setDateType(type);
}

UConditionDate::UConditionDate(QObject *parent)
    :UCondition(parent, UEConditionType::Date)
{
    setBeginDate    (QDate::currentDate());
    setEndDate      (QDate::currentDate());

    setDateType(UEConditionDateType::DDMMYYYY);
}

UConditionDate::UConditionDate(const UConditionDate* conditionDate)
    : UCondition(conditionDate)
{
    setBeginDate    (conditionDate->getBeginDate());
    setEndDate      (conditionDate->getEndDate());

    setDateType(conditionDate->getDateType());
}

void UConditionDate::read(const QJsonObject &jsonObj)
{
    UCondition::read(jsonObj);

    QDate tmp = QDate::fromString(jsonObj["beginDate"].toString(), Qt::DateFormat::ISODate);
    setBeginDate(tmp);

    tmp = QDate::fromString(jsonObj["endDate"].toString(), Qt::DateFormat::ISODate);
    setEndDate(tmp);
}

void UConditionDate::write(QJsonObject &jsonObj) const
{
    UCondition::write(jsonObj);
    jsonObj["beginDate"] = m_beginDate.toString(Qt::DateFormat::ISODate);
    jsonObj["endDate"] = m_endDate.toString(Qt::DateFormat::ISODate);
}

