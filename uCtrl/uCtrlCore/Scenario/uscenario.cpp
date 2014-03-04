#include "uscenario.h"
#include <sstream>

UScenario::UScenario(const UScenario& scenario)
{
    this->id = scenario.id;
    this->name = scenario.name;
    this->scenarioTasks = scenario.scenarioTasks;
}

json::Object UScenario::ToObject()
{
	json::Object obj;
	FillObject(obj);
	return obj;
}

void UScenario::FillObject(json::Object& obj)
{
	obj["id"] = id;
	obj["name"] = name;

    // WARNING : Custom code
    obj["scenarioTasks_size"] = (int) scenarioTasks.size();
    for (int i = 0; i < scenarioTasks.size(); i++)
    {
        std::ostringstream oss;
        oss << "scenarioTasks[" << i << "]";

        std::string key = oss.str();
        obj[key] = scenarioTasks[i].ToObject();
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
    int scenarioTasks_size = obj["scenarioTasks_size"];
    for (int i = 0 ; i < scenarioTasks_size; i++)
    {
        std::ostringstream oss;
        oss << "scenarioTasks[" << i << "]";

        std::string key = oss.str();
        UTask task = UTask::Deserialize(obj[key]);
        scenarioTasks.push_back(task);
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

