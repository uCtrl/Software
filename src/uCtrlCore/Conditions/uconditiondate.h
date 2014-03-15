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
    UConditionDate(const UConditionDate& conditionDate);
    int getComparisonPossible();
    UEConditionDateType::Type getConditionDateType() { return (UEConditionDateType::Type)m_conditionDateType; }

END_DECLARE_JSON_CLASS()

#endif // UCONDITIONDATE_H
