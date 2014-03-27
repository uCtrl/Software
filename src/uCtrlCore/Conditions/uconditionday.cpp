#include "uconditionday.h"

UConditionDay::UConditionDay() : UCondition()
{
}

UConditionDay::UConditionDay(const UConditionDay& conditionDay) : UCondition(conditionDay)
{    
    setConditionType(UEConditionType::Day);
}

void UConditionDay::FillObject(json::Object& obj) const
{
	UCondition::FillObject(obj);
    obj["weekDay1"] = getWeekDay1();
    obj["weekDay2"] = getWeekDay2();
}

void UConditionDay::FillMembers(const json::Object& obj)
{
	UCondition::FillMembers(obj);
    setWeekDay1(obj["weekDay1"]);
    setWeekDay2(obj["weekDay2"]);
}
