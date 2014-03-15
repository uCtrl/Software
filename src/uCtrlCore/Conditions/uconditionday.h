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

BEGIN_DECLARE_JSON_CHILD_CLASS_ARGS2(UConditionDay, UCondition, int, m_weekDay1, int, m_weekDay2)

public:
    UConditionDay(const UConditionDay& conditionDay);
    int getComparisonPossible() { return UEComparisonPossible::Equals | UEComparisonPossible::InBetween; }

END_DECLARE_JSON_CLASS()

#endif // UCONDITIONDAY_H
