#include "ucondition.h"
#include "../Utility/uniqueidgenerator.h"

UCondition::UCondition(const UCondition& condition)
{
    this->m_id = condition.m_id;
}

json::Object UCondition::ToObject()
{
	json::Object obj;
	FillObject(obj);
	return obj;
}

void UCondition::FillObject(json::Object& obj)
{
    obj["m_id"] = m_id;
}

std::string UCondition::Serialize()
{
	json::Object obj = ToObject();
	return json::Serialize(obj);
}

void UCondition::FillMembers(const json::Object& obj)
{
    m_id = obj["m_id"];
}

UCondition UCondition::Deserialize(const json::Object& obj)
{
	UCondition o;
	o.FillMembers(obj);
	return o;
}

