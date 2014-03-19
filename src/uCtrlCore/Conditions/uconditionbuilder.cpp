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
        m_condition = new UConditionDate();
        break;
    case UEConditionType::Day:
        m_condition = new UConditionDay();
        break;
    case UEConditionType::Time:
        m_condition = new UConditionTime();
        break;
    default:
        break;
    }

    m_condition->m_id = UniqueIdGenerator::GenerateUniqueId();
}

UConditionBuilder::UConditionBuilder(UConditionBuilderObserver* conditionBuilderObserver, const UCondition& condition)
    : m_conditionBuilderObserver(conditionBuilderObserver)
    , m_isDirty(false)
{
    switch (condition.getConditionType()) {
    case UEConditionType::Date:
        m_condition = new UConditionDate((const UConditionDate)condition);
        break;
    case UEConditionType::Day:
        m_condition = new UConditionDay((const UConditionDay)condition);
        break;
    case UEConditionType::Time:
        m_condition = new UConditionTime((const UConditionTime)condition);
        break;
    default:
        break;
    }
}

UConditionBuilder::~UConditionBuilder()
{
    delete m_condition;
    m_condition = NULL;
}

void UConditionBuilder::setValue1(void* value)
{
    m_condition->setValue1(value);
}

void UConditionBuilder::setValue2(void* value)
{
    m_condition->setValue2(value);
}

void UConditionBuilder::notifyConditionUpdate()
{
    if (m_conditionBuilderObserver)
        m_conditionBuilderObserver->onConditionUpdated(*m_condition);

    m_isDirty = false;
}
