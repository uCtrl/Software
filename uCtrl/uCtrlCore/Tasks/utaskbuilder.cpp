#include "utaskbuilder.h"
#include "../Utility/uniqueidgenerator.h"

UTaskBuilder::UTaskBuilder(UTaskBuilderObserver* taskBuilderObserver)
    : m_taskBuilderObserver(taskBuilderObserver)
    , m_isDirty(false)
{
    m_task.id = UniqueIdGenerator::GenerateUniqueId();
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
