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

QObject* UScenario::createTask() {
    return new UTask(this);
}

void UScenario::addTask(UTask* task) {
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_tasks.push_back(task);
    endInsertRows();
}

QObject* UScenario::getTaskAt(int index) const {
    if (index < 0 || index >= taskCount())
        return 0;

    return (QObject*) ( getTasks().at(index) );
}

void UScenario::deleteTaskAt(int index) {
    if (index < 0 || index >= taskCount())
        return;

    beginRemoveRows(QModelIndex(), index, index);

    QObject* task = getTaskAt(index);
    delete task;
    task = NULL;
    m_tasks.removeAt(index);

    endRemoveRows();
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
        obj[key] = getTasks()[i]->toObject();
    }
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
        UTask* task = new UTask(this);
        task->deserialize(obj[key]);
        m_tasks.push_back(task);
    }
}
