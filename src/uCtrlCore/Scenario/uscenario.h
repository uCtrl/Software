#ifndef USCENARIO_H
#define USCENARIO_H

#include "Serialization/JsonMacros.h"
#include "Tasks/utask.h"
#include "Conditions/ucondition.h"
#include <string>
#include <vector>

BEGIN_DECLARE_JSON_CLASS_ARGS4(UScenario, int, m_id, std::string, m_name, std::vector<UTask>, m_tasks, std::vector<UCondition>, m_conditions)

public:
    UScenario(const UScenario& scenario);
    ~UScenario();

    // accessors
    int id() const{ return m_id; }
    const std::string& name() const { return m_name; }
    const std::vector<UTask>& tasks() const { return m_tasks; }
    const std::vector<UCondition>& conditions() const { return m_conditions; }

END_DECLARE_JSON_CLASS()

#endif // USCENARIO_H
