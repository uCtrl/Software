#ifndef USCENARIOBUILDER_H
#define USCENARIOBUILDER_H

#include "uscenario.h"

class UScenarioBuilder : public UScenario
{
    //UScenario uscenario;

public:
    UScenarioBuilder();
    UScenarioBuilder(UScenario const&);
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
