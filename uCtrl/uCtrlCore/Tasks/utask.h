#ifndef UTASK_H
#define UTASK_H

#include "../Serialization/JsonMacros.h"
#include "../Conditions/ucondition.h"
#include <string>
#include <vector>

BEGIN_DECLARE_JSON_CLASS_ARGS4(UTask, int, m_id, std::string, m_name, std::string, m_status, std::vector<UCondition*>, m_conditions)

public:
    UTask(const UTask& task);
    UTask(std::string status);
    ~UTask();
    void addCondition( UCondition* cond) ;
    int conditionCount() const;

    // "accessors"
    int id() const {return m_id;}
    std::string name() const { return m_name; }
    std::string status() const { return m_status; }
    std::vector<UCondition*> conditions() const { return m_conditions; }

    UCondition* conditionAt( int index ) const;
END_DECLARE_JSON_CLASS()

#endif // UTASK_H
