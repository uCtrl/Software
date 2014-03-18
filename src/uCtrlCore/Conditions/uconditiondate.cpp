#include "uconditiondate.h"

UConditionDate::UConditionDate(const UConditionDate& conditionDate)
    : UCondition(conditionDate)
{
}

json::Object UConditionDate::ToObject() const
{
	json::Object obj;
	FillObject(obj);
	return obj;
}

void UConditionDate::FillObject(json::Object& obj) const
{
	UCondition::FillObject(obj);
}

void UConditionDate::FillMembers(const json::Object& obj)
{
	UCondition::FillMembers(obj);
}
