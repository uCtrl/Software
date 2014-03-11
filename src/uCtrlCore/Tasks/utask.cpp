#include "utask.h"
#include <sstream>

UTask::UTask(const UTask& task)
{
    m_id = task.id();
    m_name = task.name();
    m_status = task.status();
    m_conditions = task.conditions();
}

UTask::UTask(std::string status): m_status(status)
{
}

UTask::~UTask()
{
    // TODO: properly delete m_conditions data
    m_conditions.clear();
}

json::Object UTask::ToObject()
{
	json::Object obj;
	FillObject(obj);
	return obj;
}

void UTask::FillObject(json::Object& obj)
{
    obj["id"] = m_id;
    obj["name"] = m_name;

    // WARNING : Custom code
    obj["m_conditions_size"] = (int) m_conditions.size();
    for (int i = 0; i < m_conditions.size(); i++)
    {
        std::ostringstream oss;
        oss << "m_conditions[" << i << "]";

        std::string key = oss.str();
        obj[key] = m_conditions[i].ToObject();
    }

}

std::string UTask::Serialize()
{
	json::Object obj = ToObject();
	return json::Serialize(obj);
}

void UTask::FillMembers(const json::Object& obj)
{
    m_id = obj["id"];
    m_name = obj["name"].ToString();

    // WARNING : Custom code
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

UTask UTask::Deserialize(const json::Object& obj)
{
	UTask o;
	o.FillMembers(obj);
	return o;
}
