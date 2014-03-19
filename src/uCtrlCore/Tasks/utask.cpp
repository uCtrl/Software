#include "utask.h"
#include <sstream>

UTask::UTask(const UTask& task)
{
    m_id = task.getId();
    m_name = task.getName();
    m_status = task.getStatus();
    m_conditions = task.getConditions();
}

UTask::UTask(std::string status): m_status(status)
{
}

UTask::~UTask()
{
    // TODO: properly delete m_conditions data
    m_conditions.clear();
}

void UTask::FillObject(json::Object& obj) const
{
    obj["id"] = m_id;
    obj["name"] = m_name;
    obj["status"] = m_status;

    // WARNING : Custom code
    obj["conditions_size"] = (int) m_conditions.size();
    for (int i = 0; i < m_conditions.size(); i++)
    {
        std::ostringstream oss;
        oss << "conditions[" << i << "]";

        std::string key = oss.str();
        obj[key] = m_conditions[i].ToObject();
    }

}

void UTask::FillMembers(const json::Object& obj)
{
    m_id = obj["id"];
    m_name = obj["name"].ToString();
    m_status = obj["status"].ToString();

    // WARNING : Custom code
    int m_conditions_size = obj["conditions_size"];
    for (int i = 0 ; i < m_conditions_size; i++)
    {
        std::ostringstream oss;
        oss << "conditions[" << i << "]";

        std::string key = oss.str();
        UCondition condition = UCondition::Deserialize(obj[key]);
        m_conditions.push_back(condition);
    }
}
