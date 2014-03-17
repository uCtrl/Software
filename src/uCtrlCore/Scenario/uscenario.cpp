#include "uscenario.h"
#include <sstream>


UScenario::UScenario(const UScenario& scenario)
{
    this->m_id = scenario.m_id;
    this->m_name = scenario.m_name;
    this->m_tasks = scenario.m_tasks;
}

json::Object UScenario::ToObject() const
{
	json::Object obj;
	FillObject(obj);
	return obj;
}


UScenario::~UScenario()
{
    // TODO: properly delete m_tasks data
    m_tasks.clear();
}

void UScenario::FillObject(json::Object& obj) const
{
    obj["id"] = m_id;
    obj["name"] = m_name;

    // WARNING : Custom code
    obj["tasks_size"] = (int) m_tasks.size();
    for (int i = 0; i < m_tasks.size(); i++)
    {
        std::ostringstream oss;
        oss << "tasks[" << i << "]";

        std::string key = oss.str();
        obj[key] = m_tasks[i].ToObject();
    }

    obj["conditions_size"] = (int) m_conditions.size();
    for (int i = 0; i < m_conditions.size(); i++)
    {
        std::ostringstream oss;
        oss << "scenarioConditions[" << i << "]";

        std::string key = oss.str();
        obj[key] = m_conditions[i].ToObject();
    }
}

std::string UScenario::Serialize() const
{
	json::Object obj = ToObject();
	return json::Serialize(obj);
}

void UScenario::FillMembers(const json::Object& obj)
{
    m_id = obj["id"];
    m_name = obj["name"].ToString();

    // WARNING : Custom code
    int m_tasks_size = obj["tasks_size"];
    for (int i = 0 ; i < m_tasks_size; i++)
    {
        std::ostringstream oss;
        oss << "tasks[" << i << "]";

        std::string key = oss.str();
        UTask task = UTask::Deserialize(obj[key]);
        m_tasks.push_back(task);
    }

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

UScenario UScenario::Deserialize(const json::Object& obj)
{
	UScenario o;
	o.FillMembers(obj);
	return o;
}

