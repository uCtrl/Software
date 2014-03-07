#ifndef UCONDITION_H
#define UCONDITION_H

#include "../Serialization/JsonMacros.h"

BEGIN_DECLARE_JSON_CLASS_ARGS1( UCondition, int, m_id )

public:
    UCondition( const UCondition& condition );
    UCondition( int id ): m_id (id ) { };
    int id() const { return this->m_id; }
    static UCondition CreateNewCondition();

END_DECLARE_JSON_CLASS()

#endif // UCONDITION_H
