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

BEGIN_DECLARE_JSON_CLASS_ARGS3( UCondition, int, Id, int, ConditionType, int, CurrentComparisonType )

public:
    UCondition( const UCondition& condition );

    UEConditionType::Type getUEConditionType() const { return (UEConditionType::Type)m_ConditionType; }

    virtual int getComparisonPossible() { return 0; }
    virtual void setValue1(void* value) {}
    virtual void setValue2(void* value) {}

END_DECLARE_JSON_CLASS()

#endif // UCONDITION_H
