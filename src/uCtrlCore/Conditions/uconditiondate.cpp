#include "uconditiondate.h"

UConditionDate::UConditionDate(const UConditionDate& conditionDate)
    : UCondition(conditionDate)
{
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

json::Object UConditionDate::ToObject()
{
	json::Object obj;
	FillObject(obj);
	return obj;
}

void UConditionDate::FillObject(json::Object& obj)
{
	UCondition::FillObject(obj);
	obj["m_conditionDateType"] = m_conditionDateType;
	obj["m_date1"] = m_date1.ToObject();
	obj["m_date2"] = m_date2.ToObject();
}

std::string UConditionDate::Serialize()
{
	json::Object obj = ToObject();
	return json::Serialize(obj);
}

void UConditionDate::FillMembers(const json::Object& obj)
{
	UCondition::FillMembers(obj);
	m_conditionDateType = obj["m_conditionDateType"];
	m_date1 = UDate::Deserialize(obj["m_date1"].ToObject());
	m_date2 = UDate::Deserialize(obj["m_date2"].ToObject());
}

UConditionDate UConditionDate::Deserialize(const json::Object& obj)
{
	UConditionDate o;
	o.FillMembers(obj);
	return o;
}

