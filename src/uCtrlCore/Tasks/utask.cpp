#include "utask.h"
#include "Utility/uniqueidgenerator.h"
#include <sstream>

UTask::UTask()
{
    setId(UniqueIdGenerator::GenerateUniqueId());
}

UTask::UTask(const UTask& task)
{
    setId(task.getId());
    setName(task.getName());
    setStatus(task.getStatus());
    setConditions(task.getConditions());
}

UTask::UTask(std::string status): m_Status(status)
{
}

UTask::~UTask()
{
    // TODO: properly delete m_conditions data
    m_Conditions.clear();
}

void UTask::FillObject(json::Object& obj) const
{
    obj["id"] = getId();
    obj["name"] = getName();
    obj["status"] = getStatus();

    // WARNING : Custom code
    obj["conditions_size"] = (int) getConditions().size();
    for (int i = 0; i < getConditions().size(); i++)
    {
        std::ostringstream oss;
        oss << "conditions[" << i << "]";

        std::string key = oss.str();
        obj[key] = getConditions()[i].ToObject();
    }

}

void UTask::FillMembers(const json::Object& obj)
{
    setId(obj["id"]);
    setName(obj["name"].ToString());
    setStatus(obj["status"].ToString());

    // WARNING : Custom code
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
