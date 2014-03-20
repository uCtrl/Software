#include "uscenario.h"
#include "Utility/uniqueidgenerator.h"
#include <sstream>

UScenario::UScenario()
{
    setId(UniqueIdGenerator::GenerateUniqueId());
    setName("Undefined");
}

UScenario::UScenario(const UScenario& scenario)
{
    setId(scenario.getId());
    setName(scenario.getName());
    setTasks(scenario.getTasks());
}

UScenario::~UScenario()
{
    // TODO: properly delete m_tasks data
    m_Tasks.clear();
}

void UScenario::FillObject(json::Object& obj) const
{
    obj["id"] = getId();
    obj["name"] = getName();

    // WARNING : Custom code
    obj["tasks_size"] = (int) getTasks().size();
    for (int i = 0; i < getTasks().size(); i++)
    {
        std::ostringstream oss;
        oss << "tasks[" << i << "]";

        std::string key = oss.str();
        obj[key] = getTasks()[i].ToObject();
    }

    obj["conditions_size"] = (int) getConditions().size();
    for (int i = 0; i < getConditions().size(); i++)
    {
        std::ostringstream oss;
        oss << "scenarioConditions[" << i << "]";

        std::string key = oss.str();
        obj[key] = getConditions()[i].ToObject();
    }
}

void UScenario::FillMembers(const json::Object& obj)
{
    setId(obj["id"]);
    setName(obj["name"].ToString());

    // WARNING : Custom code
    int m_tasks_size = obj["tasks_size"];
    for (int i = 0 ; i < m_tasks_size; i++)
    {
        std::ostringstream oss;
        oss << "tasks[" << i << "]";

        std::string key = oss.str();
        UTask task = UTask::Deserialize(obj[key]);
        m_Tasks.push_back(task);
    }

    int m_conditions_size = obj["conditions_size"];
    for (int i = 0 ; i < m_conditions_size; i++)
    {
        std::ostringstream oss;
        oss << "conditions[" << i << "]";

        std::string key = oss.str();
        UCondition condition = UCondition::Deserialize(obj[key]);
        m_Conditions.push_back(condition);
    }
}
