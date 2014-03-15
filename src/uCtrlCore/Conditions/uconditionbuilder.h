#ifndef UCONDITIONBUILDER_H
#define UCONDITIONBUILDER_H

#include "ucondition.h"
#include "uconditionbuilderobserver.h"

class UConditionBuilder
{
public:
    UConditionBuilder(UConditionBuilderObserver* conditionBuilderObserver, UEConditionType::Type conditionType);
    UConditionBuilder(UConditionBuilderObserver* conditionBuilderObserver, const UCondition& condition);
    ~UConditionBuilder();

    void setComparisonType(UEComparisonPossible::Type comparisonType) { m_condition->m_currentComparisonType = comparisonType; }
    void setValue1(void* value);
    void setValue2(void* value);

    const UCondition* getCondition() { return m_condition; }
    bool isDirty() const { return m_isDirty; }

    void notifyConditionUpdate();
private:
    UCondition* m_condition;
    UConditionBuilderObserver* m_conditionBuilderObserver;
    bool m_isDirty;
};

#endif // UCONDITIONBUILDER_H
