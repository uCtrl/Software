#ifndef USCENARIOBUILDER_H
#define USCENARIOBUILDER_H

class UScenarioBuilder
{
public:
    UScenarioBuilder();
    ~UScenarioBuilder();

    void UScenarioBuilder(const UScenario &scenario);
    void AddScenario();
    void EditScenrio();
    void DeleteScenario();
    void NotifyScenarioUpdate();

private:
    bool IsDirty;
};

#endif // USCENARIOBUILDER_H
