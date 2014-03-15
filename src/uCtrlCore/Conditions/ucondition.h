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
        Date,
        Day,
        Time
    };
}

BEGIN_DECLARE_JSON_CLASS_ARGS2( UCondition, int, m_id, int, m_currentComparisonType )

public:
    UCondition( const UCondition& condition );

    int id() const { return m_id; }
    int getCurrentComparisonType() { return m_currentComparisonType; }
    virtual int getComparisonPossible() { return 0; }

END_DECLARE_JSON_CLASS()

#endif // UCONDITION_H
