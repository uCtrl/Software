#include "uscenario.h"
#include "Utility/uniqueidgenerator.h"
#include <sstream>

UScenario::UScenario(QObject* parent) : QAbstractListModel(parent)
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

QObject* UScenario::getTaskAt(int index) const
{
    if (index <= getTasks().count()) {
        return (QObject*) ( getTasks().at(index) );
    }
    return 0;
}

void UScenario::read(const QJsonObject &jsonObj)
{
    this->setId(jsonObj["id"].toInt());
    this->setName(jsonObj["name"].toString());

    QJsonArray tasksArray = jsonObj["tasks"].toArray();
    foreach(QJsonValue taskJson, tasksArray)
    {
        UTask* t = new UTask(this);
        t->read(taskJson.toObject());
        this->m_tasks.append(t);
    }
}

void UScenario::write(QJsonObject &jsonObj) const
{
    jsonObj["id"] = getId();
    jsonObj["name"] = getName();

    QJsonArray tasksArray;
    foreach(UTask* task, this->m_tasks)
    {
        QJsonObject taskJson;
        task->write(taskJson);
        tasksArray.append(taskJson);
    }

    jsonObj["tasks"] = tasksArray;
}


