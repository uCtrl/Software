#ifndef USCENARIO_H
#define USCENARIO_H

#include "../Serialization/JsonMacros.h"
#include "../Tasks/utask.h"
#include "../Conditions/ucondition.h"
#include <string>
#include <vector>

BEGIN_DECLARE_JSON_CLASS_ARGS4(UScenario, int, id, std::string, name, std::vector<UTask>, scenarioTasks, std::vector<UCondition>, scenarioConditions)

public:
    UScenario(const UScenario& scenario);

END_DECLARE_JSON_CLASS()

#endif // USCENARIO_H
