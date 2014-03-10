#ifndef USCENARIO_H
#define USCENARIO_H

#include "../Serialization/JsonMacros.h"
#include "../Tasks/utask.h"
#include "../Conditions/ucondition.h"
#include <string>
#include <vector>

BEGIN_DECLARE_JSON_CLASS_ARGS4(UScenario, int, m_id, std::string, m_name, std::vector<UTask>, m_tasks, std::vector<UCondition>, scenarioConditions)

public:
    UScenario(const UScenario& scenario);
    ~UScenario();

    int taskCount() const;
    void addTask(const UTask& task);
    const UTask* taskAt(int index) const;

END_DECLARE_JSON_CLASS()

#endif // USCENARIO_H
