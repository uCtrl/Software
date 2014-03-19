#ifndef UCONDITION_H
#define UCONDITION_H

#include "Serialization/JsonMacros.h"

namespace UEComparisonPossible
{
    enum Type
    {
        GreaterThan = 0x1,
        LesserThan = 0x2,
        Equals = 0x4,
        InBetween = 0x8
    };
}

namespace UEConditionType
{
    enum Type
    {
        Date = 1,
        Day = 2,
        Time = 3
    };
}

BEGIN_DECLARE_JSON_CLASS_ARGS3( UCondition, int, m_id, int, m_conditionType, int, m_currentComparisonType )

public:
    UCondition( const UCondition& condition );

    int id() const { return m_id; }
    UEConditionType::Type getConditionType() const { return (UEConditionType::Type)m_conditionType; }
    int getCurrentComparisonType() const { return m_currentComparisonType; }
    virtual int getComparisonPossible() { return 0; }
    virtual void setValue1(void* value) {}
    virtual void setValue2(void* value) {}

END_DECLARE_JSON_CLASS()

#endif // UCONDITION_H
