#ifndef UCONDITIONBUILDER_H
#define UCONDITIONBUILDER_H

#include "ucondition.h"

class UConditionBuilder
{
public:
    UConditionBuilder();
    UConditionBuilder(const UCondition& condition);
    ~UConditionBuilder();

    void AddCondition();
    void EditCondition();
    void DeleteCondition();
};

#endif // UCONDITIONBUILDER_H
