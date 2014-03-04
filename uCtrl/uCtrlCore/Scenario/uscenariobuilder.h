#ifndef USCENARIOBUILDER_H
#define USCENARIOBUILDER_H

#include "uscenario.h"

class UScenarioBuilder
{

public:
    UScenarioBuilder();
    UScenarioBuilder(const UScenario& scenario);
    ~UScenarioBuilder();

    void AddScenario();
    void EditScenario();
    void DeleteScenario();
    void NotifyScenarioUpdate(int, UScenario&);

private:

    UScenario tmpScenario;
};

#endif // USCENARIOBUILDER_H
