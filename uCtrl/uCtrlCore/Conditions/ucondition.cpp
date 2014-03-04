#include "ucondition.h"

UCondition::UCondition(const UCondition& condition)
{
    this->id = condition.id;
}

json::Object UCondition::ToObject()
{
	json::Object obj;
	FillObject(obj);
	return obj;
}

void UCondition::FillObject(json::Object& obj)
{
	obj["id"] = id;
}

std::string UCondition::Serialize()
{
	json::Object obj = ToObject();
	return json::Serialize(obj);
}

void UCondition::FillMembers(const json::Object& obj)
{
	id = obj["id"];
}

UCondition UCondition::Deserialize(const json::Object& obj)
{
	UCondition o;
	o.FillMembers(obj);
	return o;
}

