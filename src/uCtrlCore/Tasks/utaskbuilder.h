#ifndef UTASKSBUILDER_H
#define UTASKSBUILDER_H

#include "utask.h"
#include "utaskbuilderobserver.h"
#include "Conditions/uconditionbuilder.h"
#include "Conditions/uconditionbuilderobserver.h"

class UTaskBuilder : public UConditionBuilderObserver
{
public:
    UTaskBuilder(UTaskBuilderObserver* taskBuilderObserver);
    UTaskBuilder(UTaskBuilderObserver* taskBuilderObserver, const UTask& task);
    ~UTaskBuilder();

    UConditionBuilder* createCondition(UEConditionType::Type conditionType);
    UConditionBuilder* editCondition(int conditionId);
    void               deleteCondition(int conditionId);

    void setName(const std::string& name);
    void setStatus(const std::string& status);

    const UTask* getTask() const { return &m_task; }
    bool         isDirty() const { return m_isDirty; }

    void notifyTaskUpdate();
    void onConditionUpdated(const UCondition& updatedCondition);

private:
    UTask m_task;
    UTaskBuilderObserver* m_taskBuilderObserver;
    bool m_isDirty;
};

#endif // UTASKSBUILDER_H
