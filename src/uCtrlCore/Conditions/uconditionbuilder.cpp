#include "uconditionbuilder.h"
#include "Utility/uniqueidgenerator.h"

UConditionBuilder::UConditionBuilder(UConditionBuilderObserver* conditionBuilderObserver)
    : m_conditionBuilderObserver(conditionBuilderObserver)
    , m_isDirty(false)
{
    m_condition.m_id = UniqueIdGenerator::GenerateUniqueId();
}

UConditionBuilder::UConditionBuilder(UConditionBuilderObserver* conditionBuilderObserver, const UCondition& condition)
    : m_conditionBuilderObserver(conditionBuilderObserver)
    , m_condition(condition)
    , m_isDirty(false)
{
}

UConditionBuilder::~UConditionBuilder()
{

}

void UConditionBuilder::notifyConditionUpdate()
{
    if (m_conditionBuilderObserver)
        m_conditionBuilderObserver->onConditionUpdated(m_condition);

    m_isDirty = false;
}
