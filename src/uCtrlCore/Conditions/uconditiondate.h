#ifndef UCONDITIONDATE_H
#define UCONDITIONDATE_H

#include "ucondition.h"
#include "udate.h"

namespace UEConditionDateType
{
    enum Type
    {
        DDMMYYYY, // Specific date (ex : June 02, 2014 to Jun 17, 2014)
        DDMM, // Specific date for any year (ex : Jun 02 to Jun 17)
        MM // Months for any year (ex : May to September)
    };
}

BEGIN_DECLARE_JSON_CHILD_CLASS_ARGS3(UConditionDate, UCondition, int, ConditionDateType, UDate, Date1, UDate, Date2)

public:
    UConditionDate(const UCondition& condition) : UCondition(condition) { m_ConditionType = UEConditionType::Date; }
    UConditionDate(const UConditionDate& conditionDate);
    int getComparisonPossible();
    UEConditionDateType::Type getConditionDateType() { return (UEConditionDateType::Type)m_ConditionDateType; }
    void setValue1(void* value);
    void setValue2(void* value);

END_DECLARE_JSON_CLASS()

#endif // UCONDITIONDATE_H
