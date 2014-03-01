#ifndef UCONDITIONBUILDER_H
#define UCONDITIONBUILDER_H

#include "ucondition.h"

class UConditionBuilder : public UCondition
{
public:
    UConditionBuilder();
    ~UConditionBuilder();

private:    
    void AddCondition();
    void EditCondition();
    void DeleteCondition();
};

#endif // UCONDITIONBUILDER_H
