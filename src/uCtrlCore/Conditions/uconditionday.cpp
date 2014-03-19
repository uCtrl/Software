#include "uconditionday.h"

UConditionDay::UConditionDay(const UConditionDay& conditionDay)
    : UCondition(conditionDay)
{
}

void UConditionDay::FillObject(json::Object& obj) const
{
	UCondition::FillObject(obj);
}

void UConditionDay::FillMembers(const json::Object& obj)
{
	UCondition::FillMembers(obj);
}
