#include "uconditiontime.h"

UConditionTime::UConditionTime() : UCondition()
{
}

UConditionTime::UConditionTime(const UConditionTime& conditionTime) : UCondition(conditionTime)
{
    setConditionType(UEConditionType::Time);
}

void UConditionTime::setValue1(void* value)
{
    UTime* time= (UTime*)value;
    m_Time1 = *time;
}

void UConditionTime::setValue2(void* value)
{
    if (getCurrentComparisonType() != UEComparisonPossible::InBetween)
        return;

    UTime* time= (UTime*)value;
    m_Time2 = *time;
}

void UConditionTime::FillObject(json::Object& obj) const
{
	UCondition::FillObject(obj);
    obj["time1"] = getTime1().ToObject();
    obj["time2"] = getTime2().ToObject();
}

void UConditionTime::FillMembers(const json::Object& obj)
{
	UCondition::FillMembers(obj);
    m_Time1 = UTime::Deserialize(obj["time1"].ToObject());
    m_Time2 = UTime::Deserialize(obj["time2"].ToObject());
}
