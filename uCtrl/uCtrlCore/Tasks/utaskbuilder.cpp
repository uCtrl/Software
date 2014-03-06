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
}
