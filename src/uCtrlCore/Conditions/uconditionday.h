#ifndef UCONDITIONDAY_H
#define UCONDITIONDAY_H

#include "ucondition.h"

namespace UEWeekDay
{
    enum Type
    {
        Sunday,
        Monday,
        Tuesday,
        Wednesday,
        Thursday,
        Friday,
        Saturday
    };
}
/*
BEGIN_DECLARE_JSON_CHILD_CLASS_ARGS2(UConditionDay, UCondition, int, WeekDay1, int, WeekDay2)

public:
    UConditionDay(const UCondition& condition) : UCondition(condition) { m_ConditionType = UEConditionType::Day; }
    UConditionDay(const UConditionDay& conditionDay);
    int getComparisonPossible() { return UEComparisonPossible::Equals | UEComparisonPossible::InBetween; }

    // TODO Set values

END_DECLARE_JSON_CLASS()
*/
#endif // UCONDITIONDAY_H
