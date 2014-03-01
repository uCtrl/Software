#ifndef USCENARIOBUILDER_H
#define USCENARIOBUILDER_H

#include "uscenario.h"

class UScenarioBuilder : public UScenario
{
    UScenario uscenario;

public:
    UScenarioBuilder();
    UScenarioBuilder(const UScenario &uscenario);
    ~UScenarioBuilder();

private:
    void AddScenario();
    void EditScenrio();
    void DeleteScenario();
    void NotifyScenarioUpdate();

};

#endif // USCENARIOBUILDER_H
