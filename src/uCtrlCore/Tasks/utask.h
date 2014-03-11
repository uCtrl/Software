#ifndef UTASK_H
#define UTASK_H

#include "../Serialization/JsonMacros.h"
#include "../Conditions/ucondition.h"
#include <string>
#include <vector>

BEGIN_DECLARE_JSON_CLASS_ARGS4(UTask, int, m_id, std::string, m_name, std::string, m_status, std::vector<UCondition>, m_conditions)

public:
    UTask(const UTask& task);
    UTask(std::string status);
    ~UTask();

    // "accessors"
    int id() const {return m_id;}
    const std::string& name() const { return m_name; }
    const std::string& status() const { return m_status; }
    const std::vector<UCondition>& conditions() const { return m_conditions; }

END_DECLARE_JSON_CLASS()

#endif // UTASK_H
