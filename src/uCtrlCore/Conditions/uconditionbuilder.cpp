#include "uconditionbuilder.h"
#include "uconditiondate.h"
#include "uconditionday.h"
#include "uconditiontime.h"
#include "Utility/uniqueidgenerator.h"

UConditionBuilder::UConditionBuilder(UConditionBuilderObserver* conditionBuilderObserver, UEConditionType::Type conditionType)
    : m_conditionBuilderObserver(conditionBuilderObserver)
    , m_isDirty(false)
{
    switch (conditionType) {
    case UEConditionType::Date:
        m_condition = UConditionDate();
        break;
    case UEConditionType::Day:
        m_condition = UConditionDay();
        break;
    case UEConditionType::Time:
        m_condition = UConditionTime();
        break;
    default:
        break;
    }

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
