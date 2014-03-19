#include "uconditiontime.h"

UConditionTime::UConditionTime() : UCondition()
{
}

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

void UConditionTime::FillObject(json::Object& obj) const
{
	UCondition::FillObject(obj);
    obj["time1"] = m_time1.ToObject();
    obj["time2"] = m_time2.ToObject();
}

void UConditionTime::FillMembers(const json::Object& obj)
{
	UCondition::FillMembers(obj);
    m_time1 = UTime::Deserialize(obj["time1"].ToObject());
    m_time2 = UTime::Deserialize(obj["time2"].ToObject());
}
