#include "utaskbuilder.h"
#include "../Utility/uniqueidgenerator.h"

UTaskBuilder::UTaskBuilder(UTaskBuilderObserver* taskBuilderObserver)
    : m_taskBuilderObserver(taskBuilderObserver)
    , m_isDirty(false)
{
    m_task.m_id = UniqueIdGenerator::GenerateUniqueId();
}

UTaskBuilder::UTaskBuilder(UTaskBuilderObserver* taskBuilderObserver, const UTask& task)
    : m_taskBuilderObserver(taskBuilderObserver)
    , m_task(task)
    , m_isDirty(false)
{
}

UTaskBuilder::~UTaskBuilder()
{
}

UConditionBuilder* UTaskBuilder::createCondition()
{
    // TODO fix this
    return new UConditionBuilder(this, UEConditionType::Date);
}

UConditionBuilder* UTaskBuilder::editCondition(int conditionId)
{
    for (int i = 0; i < m_task.m_conditions.size(); ++i)
    {
        if (m_task.m_conditions[i].id() == conditionId)
        {
            UConditionBuilder* conditionBuilder = new UConditionBuilder(this, m_task.m_conditions[i]);
            return conditionBuilder;
        }
    }
}

void UTaskBuilder::deleteCondition(int conditionId)
{
    for (int i = 0; i < m_task.m_conditions.size(); ++i)
    {
        if (m_task.m_conditions[i].id() == conditionId)
        {
            std::vector<UCondition>::iterator iter = m_task.m_conditions.begin() + i;

            m_task.m_conditions.erase(iter);
            m_isDirty = true;
            return;
        }
    }
}

void UTaskBuilder::setName(const std::string& name)
{
    m_task.m_name = name;
}

void UTaskBuilder::setStatus(const std::string& status)
{
    m_task.m_status = status;
}

void UTaskBuilder::notifyTaskUpdate()
{
    if (m_taskBuilderObserver != NULL)
        m_taskBuilderObserver->onTaskUpdated(m_task);

    m_isDirty = false;
}

void UTaskBuilder::onConditionUpdated(const UCondition& updatedCondition)
{
    for (int i = 0; i < m_task.m_conditions.size(); ++i)
    {
        if (m_task.m_conditions[i].id() == updatedCondition.id())
        {
            std::vector<UCondition>::iterator iter = m_task.m_conditions.begin() + i;

            m_task.m_conditions.erase(iter);
            m_task.m_conditions.insert(iter, updatedCondition);
            m_isDirty = true;
            return;
        }
    }

    m_task.m_conditions.push_back(updatedCondition);
    m_isDirty = true;
}
