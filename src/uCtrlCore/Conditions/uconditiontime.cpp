#include "uconditiontime.h"

UConditionTime::UConditionTime(const UConditionTime& conditionTime)
    : UCondition(conditionTime)
{
}

json::Object UConditionTime::ToObject() const
{
	json::Object obj;
	FillObject(obj);
	return obj;
}

void UConditionTime::FillObject(json::Object& obj) const
{
	UCondition::FillObject(obj);
}

void UConditionTime::FillMembers(const json::Object& obj)
{
	UCondition::FillMembers(obj);
}
