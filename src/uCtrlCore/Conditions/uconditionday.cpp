#include "uconditionday.h"

UConditionDay::UConditionDay() : UCondition()
{
}

UConditionDay::UConditionDay(const UConditionDay& conditionDay)
    : UCondition(conditionDay)
{    
    this->m_conditionType = UEConditionType::Day;
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
	obj["m_weekDay1"] = m_weekDay1;
	obj["m_weekDay2"] = m_weekDay2;
}

std::string UConditionDay::Serialize()
{
	json::Object obj = ToObject();
	return json::Serialize(obj);
}

void UConditionDay::FillMembers(const json::Object& obj)
{
	UCondition::FillMembers(obj);
	m_weekDay1 = obj["m_weekDay1"];
	m_weekDay2 = obj["m_weekDay2"];
}

UConditionDay UConditionDay::Deserialize(const json::Object& obj)
{
	UConditionDay o;
	o.FillMembers(obj);
	return o;
}

