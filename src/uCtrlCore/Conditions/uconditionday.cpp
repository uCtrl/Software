#include "uconditionday.h"

UConditionDay::UConditionDay(const UConditionDay& conditionDay)
    : UCondition(conditionDay)
{
}

json::Object UConditionDay::ToObject() const
{
	json::Object obj;
	FillObject(obj);
	return obj;
}

void UConditionDay::FillObject(json::Object& obj) const
{
	UCondition::FillObject(obj);
}

void UConditionDay::FillMembers(const json::Object& obj)
{
	UCondition::FillMembers(obj);
}
