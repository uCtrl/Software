#ifndef USCENARIOBUILDER_H
#define USCENARIOBUILDER_H

#include "uscenario.h"

class UScenarioBuilder
{
    //UScenario uscenario;

public:
    UScenarioBuilder(const UScenario &scenario);
    ~UScenarioBuilder();

    void AddScenario();
    void EditScenrio();
    void DeleteScenario();
    void NotifyScenarioUpdate(int, UScenario&);

private:
    //Attributs
    int ID;
};

#endif // USCENARIOBUILDER_H
