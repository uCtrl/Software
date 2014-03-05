#ifndef USCENARIO_H
#define USCENARIO_H

#include "../Serialization/JsonMacros.h"
#include "../Tasks/utask.h"
#include "../Conditions/ucondition.h"
#include <string>
#include <vector>

BEGIN_DECLARE_JSON_CLASS_ARGS4(UScenario, int, id, std::string, name, std::vector<UTask*>, m_tasks, std::vector<UCondition>, scenarioConditions)

public:
    int taskCount() const;
    void addTask(UTask* task);
    UScenario(const UScenario& scenario);
    ~UScenario();
    UTask* taskAt(int index) const;

END_DECLARE_JSON_CLASS()

#endif // USCENARIO_H
