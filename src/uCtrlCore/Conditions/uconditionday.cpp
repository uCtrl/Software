#include "uconditionday.h"

UConditionDay::UConditionDay(const UConditionDay& conditionDay)
    : UCondition(conditionDay)
{
}

json::Object UConditionDay::ToObject()
{
	json::Object obj;
	FillObject(obj);
	return obj;
}

void UConditionDay::FillObject(json::Object& obj)
{
	UCondition::FillObject(obj);
}

std::string UConditionDay::Serialize()
{
	json::Object obj = ToObject();
	return json::Serialize(obj);
}

void UConditionDay::FillMembers(const json::Object& obj)
{
	UCondition::FillMembers(obj);
}

UConditionDay UConditionDay::Deserialize(const json::Object& obj)
{
	UConditionDay o;
	o.FillMembers(obj);
	return o;
}

