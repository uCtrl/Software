#ifndef UTASK_H
#define UTASK_H

#include "../Serialization/JsonMacros.h"
#include "../Conditions/ucondition.h"
#include <string>
#include <vector>

BEGIN_DECLARE_JSON_CLASS_ARGS4(UTask, int, Id, std::string, Name, std::string, Status, std::vector<UCondition>, Conditions)

public:
    UTask(const UTask& task);
    UTask(std::string status);
    ~UTask();

END_DECLARE_JSON_CLASS()

#endif // UTASK_H
