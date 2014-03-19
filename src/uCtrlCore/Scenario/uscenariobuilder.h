#ifndef USCENARIOBUILDER_H
#define USCENARIOBUILDER_H

#include "uscenario.h"
#include "uscenariobuilderobserver.h"
#include "Tasks/utask.h"
#include "Tasks/utaskbuilder.h"
#include "Tasks/utaskbuilderobserver.h"
#include "Conditions/ucondition.h"
#include "Conditions/uconditionbuilder.h"
#include "Conditions/uconditionbuilderobserver.h"

class UScenarioBuilder : public UTaskBuilderObserver, public UConditionBuilderObserver
{

public:
    UScenarioBuilder(UScenarioBuilderObserver* scenarioBuilderObserver);
    UScenarioBuilder(UScenarioBuilderObserver* scenarioBuilderObserver, const UScenario& scenario);
    ~UScenarioBuilder();

    UTaskBuilder* createTask();
    UTaskBuilder* editTask(int taskId);
    void          deleteTask(int taskId);
    void addTask(const UTask& task) { m_scenario.m_tasks.push_back(task); }
    void setName(const std::string& name) { m_scenario.m_name = name; }

    UConditionBuilder* createCondition(UEConditionType::Type conditionType);
    UConditionBuilder* editCondition(int conditionId);
    void               deleteCondition(int conditionId);

    const UScenario* getScenario() const { return &m_scenario; }
    bool             isDirty() const { return m_isDirty; }

    void notifyScenarioUpdate();
    void onTaskUpdated(const UTask& updatedTask);
    void onConditionUpdated(const UCondition& updatedCondition);

private:
    UScenarioBuilderObserver* m_scenarioBuilderObserver;
    UScenario m_scenario;

    bool m_isDirty;
};

#endif // USCENARIOBUILDER_H
