#include "utask.h"
#include <sstream>

UTask::UTask(const UTask& task)
{
    this->id = task.id;
    this->name = task.name;
    this->taskConditions = task.taskConditions;
}

json::Object UTask::ToObject()
{
	json::Object obj;
	FillObject(obj);
	return obj;
}

void UTask::FillObject(json::Object& obj)
{
	obj["id"] = id;
	obj["name"] = name;

    // WARNING : Custom code
    obj["taskConditions_size"] = (int) taskConditions.size();
    for (int i = 0; i < taskConditions.size(); i++)
    {
        std::ostringstream oss;
        oss << "taskConditions[" << i << "]";

        std::string key = oss.str();
        obj[key] = taskConditions[i].ToObject();
    }

}

std::string UTask::Serialize()
{
	json::Object obj = ToObject();
	return json::Serialize(obj);
}

void UTask::FillMembers(const json::Object& obj)
{
	id = obj["id"];
	name = obj["name"].ToString();

    // WARNING : Custom code
    int taskConditions_size = obj["taskConditions_size"];
    for (int i = 0 ; i < taskConditions_size; i++)
    {
        std::ostringstream oss;
        oss << "taskConditions[" << i << "]";

        std::string key = oss.str();
        UCondition condition = UCondition::Deserialize(obj[key]);
        taskConditions.push_back(condition);
    }
}

UTask UTask::Deserialize(const json::Object& obj)
{
	UTask o;
	o.FillMembers(obj);
	return o;
}

