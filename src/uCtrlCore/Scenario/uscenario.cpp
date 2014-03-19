#include "uscenario.h"
#include "Utility/uniqueidgenerator.h"
#include <sstream>

UScenario::UScenario()
{
    this->m_id = UniqueIdGenerator::GenerateUniqueId();
    this->m_name = "Undefined";
}

UScenario::UScenario(const UScenario& scenario)
{
    this->m_id = scenario.m_id;
    this->m_name = scenario.m_name;
    this->m_tasks = scenario.m_tasks;
}

json::Object UScenario::ToObject()
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

void UScenario::FillObject(json::Object& obj)
{
    obj["m_id"] = m_id;
    obj["m_name"] = m_name;

    // WARNING : Custom code
    obj["m_tasks_size"] = (int) m_tasks.size();
    for (int i = 0; i < m_tasks.size(); i++)
    {
        std::ostringstream oss;
        oss << "m_tasks[" << i << "]";

        std::string key = oss.str();
        obj[key] = m_tasks[i].ToObject();
    }

    obj["m_conditions_size"] = (int) m_conditions.size();
    for (int i = 0; i < m_conditions.size(); i++)
    {
        std::ostringstream oss;
        oss << "scenarioConditions[" << i << "]";

        std::string key = oss.str();
        obj[key] = m_conditions[i].ToObject();
    }
}

std::string UScenario::Serialize()
{
	json::Object obj = ToObject();
	return json::Serialize(obj);
}

void UScenario::FillMembers(const json::Object& obj)
{
    m_id = obj["m_id"];
    m_name = obj["m_name"].ToString();

    // WARNING : Custom code
    int m_tasks_size = obj["m_tasks_size"];
    for (int i = 0 ; i < m_tasks_size; i++)
    {
        std::ostringstream oss;
        oss << "m_tasks[" << i << "]";

        std::string key = oss.str();
        UTask task = UTask::Deserialize(obj[key]);
        m_tasks.push_back(task);
    }

    int m_conditions_size = obj["m_conditions_size"];
    for (int i = 0 ; i < m_conditions_size; i++)
    {
        std::ostringstream oss;
        oss << "m_conditions[" << i << "]";

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

