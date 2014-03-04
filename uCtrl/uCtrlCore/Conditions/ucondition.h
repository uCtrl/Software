#ifndef UCONDITION_H
#define UCONDITION_H

#include "../Serialization/JsonMacros.h"

BEGIN_DECLARE_JSON_CLASS_ARGS1(UCondition, int, id)

public:
    UCondition(const UCondition& condition);

END_DECLARE_JSON_CLASS()

#endif // UCONDITION_H
