#include "uconditiondate.h"

UConditionDate::UConditionDate() : UCondition()
{
}

UConditionDate::UConditionDate(const UConditionDate& conditionDate)
    : UCondition(conditionDate)
{
    this->m_conditionType = UEConditionType::Date;
    this->m_date1 = conditionDate.m_date1;
    this->m_date2 = conditionDate.m_date2;
}

int UConditionDate::getComparisonPossible()
{
    using namespace UEComparisonPossible;

    switch (m_conditionDateType) {
    case UEConditionDateType::DDMMYYYY:
        return GreaterThan | LesserThan | Equals | InBetween;
    case UEConditionDateType::DDMM:
        // TODO : Define if greaterthan and lesserthan makes sense
        return GreaterThan | LesserThan | Equals | InBetween;
    case UEConditionDateType::MM:
        return Equals | InBetween;
    default:
        return 0;
    }
}

void UConditionDate::setValue1(void* value)
{
    UDate* date = (UDate*)value;
    m_date1 = *date;
}

void UConditionDate::setValue2(void* value)
{
    if (m_currentComparisonType != UEComparisonPossible::InBetween)
        return;

    UDate* date = (UDate*)value;
    m_date2 = *date;
}

void UConditionDate::FillObject(json::Object& obj) const
{
	UCondition::FillObject(obj);
    obj["conditionDateType"] = m_conditionDateType;
    obj["date1"] = m_date1.ToObject();
    obj["date2"] = m_date2.ToObject();
}

void UConditionDate::FillMembers(const json::Object& obj)
{
	UCondition::FillMembers(obj);
    m_conditionDateType = obj["conditionDateType"];
    m_date1 = UDate::Deserialize(obj["date1"].ToObject());
    m_date2 = UDate::Deserialize(obj["date2"].ToObject());
}
