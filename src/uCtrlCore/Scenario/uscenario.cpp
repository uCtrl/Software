#include "uscenario.h"
#include "Utility/uniqueidgenerator.h"
#include <sstream>

UScenario::UScenario(QObject* parent) : QAbstractListModel(parent), m_device(parent)
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

    emit tasksChanged(m_tasks);
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

    emit tasksChanged(m_tasks);
}

void UScenario::moveTask(int indexSource, int indexDestination)
{
    if (indexDestination < 0 || indexDestination >= m_tasks.size())
        return;

    if (indexSource < 0 || indexSource >= m_tasks.size())
        return;

    int sourceFirst = indexSource;
    int sourceLast = indexSource;
    int destinationRow = indexDestination;

    if (indexSource < indexDestination) {
        sourceFirst = indexSource + 1;
        sourceLast = indexDestination;
        destinationRow = indexSource;
    }

    beginMoveRows(QModelIndex(), sourceFirst, sourceLast, QModelIndex(), destinationRow);

    m_tasks.move(indexSource, indexDestination);

    endMoveRows();

    emit tasksChanged(m_tasks);
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


