#ifndef UCONDITIONTIME_H
#define UCONDITIONTIME_H

#include "ucondition.h"
#include "utime.h"

BEGIN_DECLARE_JSON_CHILD_CLASS_ARGS2(UConditionTime, UCondition, UTime, m_time1, UTime, m_time2)

public:
    UConditionTime(const UCondition& condition) : UCondition(condition) { m_conditionType = UEConditionType::Time; }
    UConditionTime(const UConditionTime& conditionTime);
    int getComparisonPossible() { return UEComparisonPossible::InBetween; }
    virtual void setValue1(void* value);
    virtual void setValue2(void* value);

END_DECLARE_JSON_CLASS()

#endif // UCONDITIONTIME_H
