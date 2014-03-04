#include "uconditiondate.h"

UConditionDate::UConditionDate(const UConditionDate& conditionDate)
    : UCondition(conditionDate)
{
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
}

std::string UConditionDate::Serialize()
{
	json::Object obj = ToObject();
	return json::Serialize(obj);
}

void UConditionDate::FillMembers(const json::Object& obj)
{
	UCondition::FillMembers(obj);
}

UConditionDate UConditionDate::Deserialize(const json::Object& obj)
{
	UConditionDate o;
	o.FillMembers(obj);
	return o;
}

