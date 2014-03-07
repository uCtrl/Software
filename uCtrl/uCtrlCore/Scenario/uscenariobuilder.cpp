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
    , m_scenario(scenario)
    , m_isDirty(false)
{
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
        if (m_scenario.m_tasks[i].id() == taskId)
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
        if (m_scenario.m_tasks[i].id() == taskId)
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
        if (m_scenario.m_tasks[i].id() == updatedTask.id())
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


