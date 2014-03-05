#include "uscenario.h"
#include <sstream>

int UScenario::taskCount() const
{
    return m_tasks.size();
}

UScenario::UScenario(const UScenario& scenario)
{
    this->id = scenario.id;
    this->name = scenario.name;
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

void UScenario::addTask(UTask* task)
{
    m_tasks.insert(m_tasks.end(), task); 
}

UTask* UScenario::taskAt(int index) const
{
    if (m_tasks.size() > index)
    {
        return m_tasks[index];
    }
}



void UScenario::FillObject(json::Object& obj)
{
	obj["id"] = id;
	obj["name"] = name;

    // WARNING : Custom code
    obj["m_tasks_size"] = (int) m_tasks.size();
    for (int i = 0; i < m_tasks.size(); i++)
    {
        std::ostringstream oss;
        oss << "m_tasks[" << i << "]";

        std::string key = oss.str();
        obj[key] = m_tasks[i]->ToObject();
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
	id = obj["id"];
    name = obj["name"].ToString();

    // WARNING : Custom code
    int m_tasks_size = obj["m_tasks_size"];
    for (int i = 0 ; i < m_tasks_size; i++)
    {
        std::ostringstream oss;
        oss << "m_tasks[" << i << "]";

        std::string key = oss.str();
        UTask task = UTask::Deserialize(obj[key]);
        m_tasks.push_back(new UTask(task));
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

