#ifndef USCENARIO_H
#define USCENARIO_H

#include "Serialization/JsonMacros.h"
#include "Tasks/utask.h"
#include "Conditions/ucondition.h"
#include <string>
#include <vector>

BEGIN_DECLARE_JSON_CLASS_ARGS4(UScenario, int, Id, std::string, Name, std::vector<UTask>, Tasks, std::vector<UCondition>, Conditions)

public:
    UScenario(const UScenario& scenario);
    ~UScenario();

END_DECLARE_JSON_CLASS()

#endif // USCENARIO_H
