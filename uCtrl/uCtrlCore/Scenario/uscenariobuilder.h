#ifndef USCENARIOBUILDER_H
#define USCENARIOBUILDER_H

#include "uscenario.h"
#include "uscenariobuilderobserver.h"
#include "../Tasks/utask.h"
#include "../Tasks/utaskbuilder.h"
#include "../Tasks/utaskbuilderobserver.h"
#include "../Conditions/ucondition.h"
#include "../Conditions/uconditionbuilder.h"

class UScenarioBuilder : public UTaskBuilderObserver
{

public:
    UScenarioBuilder(UScenarioBuilderObserver* scenarioBuilderObserver);
    UScenarioBuilder(UScenarioBuilderObserver* scenarioBuilderObserver, const UScenario& scenario);
    ~UScenarioBuilder();

    UTaskBuilder* createTask();
    UTaskBuilder* editTask(int taskId);
    void          deleteTask(int taskId);

    const UScenario* getScenario() const { return &m_scenario; }
    bool             isDirty() const { return m_isDirty; }

    void notifyScenarioUpdate();
    void onTaskUpdated(const UTask& updatedTask);

private:
    UScenarioBuilderObserver* m_scenarioBuilderObserver;
    UScenario m_scenario;

    bool m_isDirty;
};

#endif // USCENARIOBUILDER_H
