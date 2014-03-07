#include "uscenario.h"
#include <sstream>

int UScenario::taskCount() const
{
    return m_tasks.size();
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

void UScenario::addTask(const UTask& task)
{
    m_tasks.push_back(task);
}

const UTask* UScenario::taskAt(int index) const
{
    if (m_tasks.size() > index)
    {
        return &m_tasks[index];
    }
    return NULL;
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

    obj["scenarioConditions_size"] = (int) scenarioConditions.size();
    for (int i = 0; i < scenarioConditions.size(); i++)
    {
        std::ostringstream oss;
        oss << "scenarioConditions[" << i << "]";

        std::string key = oss.str();
        obj[key] = scenarioConditions[i].ToObject();
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

    int scenarioConditions_size = obj["scenarioConditions_size"];
    for (int i = 0 ; i < scenarioConditions_size; i++)
    {
        std::ostringstream oss;
        oss << "scenarioConditions[" << i << "]";

        std::string key = oss.str();
        UCondition condition = UCondition::Deserialize(obj[key]);
        scenarioConditions.push_back(condition);
    }
}

UScenario UScenario::Deserialize(const json::Object& obj)
{
	UScenario o;
	o.FillMembers(obj);
	return o;
}

