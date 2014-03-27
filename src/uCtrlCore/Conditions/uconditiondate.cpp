#include "uconditiondate.h"

UConditionDate::UConditionDate() : UCondition()
{
}

UConditionDate::UConditionDate(const UConditionDate& conditionDate) : UCondition(conditionDate)
{
    setConditionType(UEConditionType::Date);
    setDate1(conditionDate.getDate1());
    setDate2(conditionDate.getDate2());
}

int UConditionDate::getComparisonPossible()
{
    using namespace UEComparisonPossible;

    switch (getConditionDateType()) {
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
    m_Date1 = *date;
}

void UConditionDate::setValue2(void* value)
{
    if (getCurrentComparisonType() != UEComparisonPossible::InBetween) return;

    UDate* date = (UDate*)value;
    m_Date2 = *date;
}

void UConditionDate::FillObject(json::Object& obj) const
{
	UCondition::FillObject(obj);
    obj["conditionDateType"] = getConditionDateType();
    obj["date1"] = getDate1().ToObject();
    obj["date2"] = getDate2().ToObject();
}

void UConditionDate::FillMembers(const json::Object& obj)
{
	UCondition::FillMembers(obj);
    m_ConditionDateType = obj["conditionDateType"];
    m_Date1 = UDate::Deserialize(obj["date1"].ToObject());
    m_Date2 = UDate::Deserialize(obj["date2"].ToObject());
}
