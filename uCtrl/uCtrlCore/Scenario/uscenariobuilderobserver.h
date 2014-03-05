#ifndef USCENARIOBUILDEROBSERVER_H
#define USCENARIOBUILDEROBSERVER_H

#include "uscenario.h"

class UScenarioBuilderObserver
{
public:
    UScenarioBuilderObserver();
    virtual void onScenarioUpdated(const UScenario& updatedScenario) = 0;
};

#endif // USCENARIOBUILDEROBSERVER_H
