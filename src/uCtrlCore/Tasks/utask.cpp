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

void UTask::addCondition(UCondition* cond)
{
    m_conditions.insert(m_conditions.end(), cond);
}

int UTask::conditionCount() const
{
    return m_conditions.size();
}

UCondition* UTask::conditionAt(int index) const
{
    if (m_conditions.size() > index)
    {
        return m_conditions[index];
    }
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
        obj[key] = m_conditions[i]->ToObject();
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
        UCondition* cond = new UCondition(condition);
        m_conditions.push_back(cond);
    }
}

UTask UTask::Deserialize(const json::Object& obj)
{
	UTask o;
	o.FillMembers(obj);
	return o;
}
