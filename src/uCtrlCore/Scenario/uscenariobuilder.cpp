#include "uscenariobuilder.h"
#include "../Utility/uniqueidgenerator.h"

UScenarioBuilder::UScenarioBuilder(UScenarioBuilderObserver* scenarioBuilderObserver)
    : m_scenarioBuilderObserver(scenarioBuilderObserver)
    , m_isDirty(false)
{
    m_scenario.m_id = UniqueIdGenerator::GenerateUniqueId();
}

UScenarioBuilder::UScenarioBuilder(UScenarioBuilderObserver* scenarioBuilderObserver, const UScenario& scenario)
    : m_scenarioBuilderObserver(scenarioBuilderObserver)
    , m_isDirty(false)
{
    m_scenario = scenario;
}

UScenarioBuilder::~UScenarioBuilder()
{
}

UTaskBuilder* UScenarioBuilder::createTask()
{
    return new UTaskBuilder(this);
}

UTaskBuilder* UScenarioBuilder::editTask(int taskId)
{
    for (int i = 0; i < m_scenario.m_tasks.size(); ++i)
    {
        if (m_scenario.m_tasks[i].getId() == taskId)
        {
            UTaskBuilder* taskBuilder = new UTaskBuilder(this, m_scenario.m_tasks[i]);
            return taskBuilder;
        }
    }
}

void UScenarioBuilder::deleteTask(int taskId)
{
    for (int i = 0; i < m_scenario.m_tasks.size(); ++i)
    {
        if (m_scenario.m_tasks[i].getId() == taskId)
        {
            std::vector<UTask>::iterator iter = m_scenario.m_tasks.begin() + i;

            m_scenario.m_tasks.erase(iter);
            m_isDirty = true;
            return;
        }
    }
}

void UScenarioBuilder::notifyScenarioUpdate()
{
    if (m_scenarioBuilderObserver != NULL)
        m_scenarioBuilderObserver->onScenarioUpdated(m_scenario);

    m_isDirty = false;
}

void UScenarioBuilder::onTaskUpdated(const UTask& updatedTask)
{
    for (int i = 0; i < m_scenario.m_tasks.size(); ++i)
    {
        if (m_scenario.m_tasks[i].getId() == updatedTask.getId())
        {
            std::vector<UTask>::iterator iter = m_scenario.m_tasks.begin() + i;

            m_scenario.m_tasks.erase(iter);
            m_scenario.m_tasks.insert(iter, updatedTask);
            m_isDirty = true;
            return;
        }
    }

    m_scenario.m_tasks.push_back(updatedTask);
    m_isDirty = true;
}

UConditionBuilder* UScenarioBuilder::createCondition()
{
    return new UConditionBuilder(this);
}

UConditionBuilder* UScenarioBuilder::editCondition(int conditionId)
{
    for (int i = 0; i < m_scenario.m_conditions.size(); ++i)
    {
        if (m_scenario.m_conditions[i].getId() == conditionId)
        {
            UConditionBuilder* conditionBuilder = new UConditionBuilder(this, m_scenario.m_conditions[i]);
            return conditionBuilder;
        }
    }
}

void UScenarioBuilder::deleteCondition(int conditionId)
{
    for (int i = 0; i < m_scenario.m_conditions.size(); ++i)
    {
        if (m_scenario.m_conditions[i].getId() == conditionId)
        {
            std::vector<UCondition>::iterator iter = m_scenario.m_conditions.begin() + i;

            m_scenario.m_conditions.erase(iter);
            m_isDirty = true;
            return;
        }
    }
}

void UScenarioBuilder::onConditionUpdated(const UCondition& updatedCondition)
{
    for (int i = 0; i < m_scenario.m_conditions.size(); ++i)
    {
        if (m_scenario.m_conditions[i].getId() == updatedCondition.getId())
        {
            std::vector<UCondition>::iterator iter = m_scenario.m_conditions.begin() + i;

            m_scenario.m_conditions.erase(iter);
            m_scenario.m_conditions.insert(iter, updatedCondition);
            m_isDirty = true;
            return;
        }
    }

    m_scenario.m_conditions.push_back(updatedCondition);
    m_isDirty = true;
}


