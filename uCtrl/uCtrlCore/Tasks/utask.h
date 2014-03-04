#ifndef UTASK_H
#define UTASK_H

#include "../Serialization/JsonMacros.h"
#include "../Conditions/ucondition.h"
#include <string>
#include <vector>

BEGIN_DECLARE_JSON_CLASS_ARGS3(UTask, int, id, std::string, name, std::vector<UCondition>, taskConditions)

public:
    UTask(const UTask& task);

END_DECLARE_JSON_CLASS()

#endif // UTASK_H
