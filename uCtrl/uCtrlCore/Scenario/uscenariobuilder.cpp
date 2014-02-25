#include "uscenariobuilder.h"

UScenarioBuilder::UScenarioBuilder(const UScenario &scenario)
{
    IsDirty = false;
    tempScenario = new UScenario(scenario);

    void AddScenario();
    {
        IsDirty = true;

    }

    void EditScenrio();
    {
        IsDirty = true;

    }

    void DeleteScenario();
    {
        IsDirty = true;

    }

    void NotifyScenarioUpdate(ID, tempScenario);
    {

    }

}
