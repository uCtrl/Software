#ifndef UCONDITIONDATE_H
#define UCONDITIONDATE_H

#include "ucondition.h"
#include "udate.h"

namespace UEConditionDateType
{
    enum Type
    {
        DDMMYYYY,
        DDMM,
        MM
    };
}

BEGIN_DECLARE_JSON_CHILD_CLASS_ARGS3(UConditionDate, UCondition, int, m_conditionDateType, UDate, m_date1, UDate, m_date2)

public:
    UConditionDate(const UCondition& condition) : UCondition(condition) { m_conditionType = UEConditionType::Date; }
    UConditionDate(const UConditionDate& conditionDate);
    int getComparisonPossible();
    UEConditionDateType::Type getConditionDateType() { return (UEConditionDateType::Type)m_conditionDateType; }
    void setValue1(void* value);
    void setValue2(void* value);

END_DECLARE_JSON_CLASS()

#endif // UCONDITIONDATE_H
