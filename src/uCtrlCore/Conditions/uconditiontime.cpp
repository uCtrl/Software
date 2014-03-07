#include "uconditiontime.h"

UConditionTime::UConditionTime(const UConditionTime& conditionTime)
    : UCondition(conditionTime)
{
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
}

std::string UConditionTime::Serialize()
{
	json::Object obj = ToObject();
	return json::Serialize(obj);
}

void UConditionTime::FillMembers(const json::Object& obj)
{
	UCondition::FillMembers(obj);
}

UConditionTime UConditionTime::Deserialize(const json::Object& obj)
{
	UConditionTime o;
	o.FillMembers(obj);
	return o;
}

