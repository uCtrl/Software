#ifndef UCONDITIONBUILDEROBSERVER_H
#define UCONDITIONBUILDEROBSERVER_H

#include "ucondition.h"

class UConditionBuilderObserver
{
public:
    UConditionBuilderObserver();
    virtual void onConditionUpdated(const UCondition& updatedCondition) = 0;
};

#endif // UCONDITIONBUILDEROBSERVER_H
