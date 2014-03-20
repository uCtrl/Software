#include "uconditionday.h"

UConditionDay::UConditionDay() : UCondition()
{
}

UConditionDay::UConditionDay(const UConditionDay& conditionDay)
    : UCondition(conditionDay)
{    
    this->m_conditionType = UEConditionType::Day;
}

void UConditionDay::FillObject(json::Object& obj) const
{
	UCondition::FillObject(obj);
    obj["weekDay1"] = m_weekDay1;
    obj["weekDay2"] = m_weekDay2;
}

void UConditionDay::FillMembers(const json::Object& obj)
{
	UCondition::FillMembers(obj);
    m_weekDay1 = obj["weekDay1"];
    m_weekDay2 = obj["weekDay2"];
}
