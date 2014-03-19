#include "uconditiontime.h"

UConditionTime::UConditionTime(const UConditionTime& conditionTime)
    : UCondition(conditionTime)
{
    this->m_conditionType = UEConditionType::Time;
}

void UConditionTime::setValue1(void* value)
{
    UTime* time= (UTime*)value;
    m_time1 = *time;
}

void UConditionTime::setValue2(void* value)
{
    if (m_currentComparisonType != UEComparisonPossible::InBetween)
        return;

    UTime* time= (UTime*)value;
    m_time2 = *time;
}

json::Object UConditionTime::ToObject()
{
	json::Object obj;
	FillObject(obj);
	return obj;
}

void UConditionTime::FillObject(json::Object& obj)
{
	UCondition::FillObject(obj);
	obj["m_time1"] = m_time1.ToObject();
	obj["m_time2"] = m_time2.ToObject();
}

std::string UConditionTime::Serialize()
{
	json::Object obj = ToObject();
	return json::Serialize(obj);
}

void UConditionTime::FillMembers(const json::Object& obj)
{
	UCondition::FillMembers(obj);
	m_time1 = UTime::Deserialize(obj["m_time1"].ToObject());
	m_time2 = UTime::Deserialize(obj["m_time2"].ToObject());
}

UConditionTime UConditionTime::Deserialize(const json::Object& obj)
{
	UConditionTime o;
	o.FillMembers(obj);
	return o;
}

