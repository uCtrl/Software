#include "uscenario.h"
#include "Utility/uniqueidgenerator.h"
#include <sstream>

UScenario::UScenario(QObject* parent)
    :QAbstractListModel(parent)
{
    setId(UniqueIdGenerator::GenerateUniqueId());
    setName("Undefined");
}

UScenario::UScenario(const UScenario *scenario)
{
    setId(scenario->getId());
    setName(scenario->getName());
    setTasks(scenario->getTasks());
}

UScenario::~UScenario()
{
    // TODO: properly delete m_tasks data
    m_tasks.clear();
}

void UScenario::fillObject(json::Object& obj) const
{
    obj["id"] = getId();
    obj["name"] = getName().toStdString();

    // WARNING : Custom code
    obj["tasks_size"] = (int) getTasks().size();
    for (int i = 0; i < getTasks().size(); i++)
    {
        std::ostringstream oss;
        oss << "tasks[" << i << "]";

        std::string key = oss.str();
        obj[key] = getTasks()[i]->ToObject();
    }
}

QObject* UScenario::getTaskAt(int index) const
{
    if (index <= getTasks().count()) {
        return (QObject*) ( getTasks().at(index) );
    }
    return 0;
}

void UScenario::fillMembers(const json::Object& obj)
{
    setId(obj["id"]);
    setName(QString::fromStdString(obj["name"].ToString()));

    // WARNING : Custom code
    int m_tasks_size = obj["tasks_size"];
    for (int i = 0 ; i < m_tasks_size; i++)
    {
        std::ostringstream oss;
        oss << "tasks[" << i << "]";

        std::string key = oss.str();
        UTask* task = new UTask();
        task->deserialize(obj[key]);
        m_tasks.push_back(task);
    }
}
