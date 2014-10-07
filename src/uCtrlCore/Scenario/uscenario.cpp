#include "uscenario.h"
#include "Utility/uniqueidgenerator.h"
#include <sstream>

UScenario::UScenario(QObject* parent) : QAbstractListModel(parent), m_device(parent)
{
}

UScenario::UScenario(QObject* parent, const QString& id) : QAbstractListModel(parent), m_device(parent)
{
    setId(id);
}

UScenario::UScenario(UScenario *scenario) : QAbstractListModel(scenario->getDevice())
{
    setId(scenario->getId());
    setName(scenario->getName());
    setTasks(scenario->copyTasks());
    m_device = scenario->getDevice();
}

UScenario::~UScenario()
{
    foreach(UTask* task, m_tasks) {
        delete task;
    }
    m_tasks.clear();
}

void UScenario::updateScenario(UScenario* scenario)
{
    setId(scenario->getId());
    setName(scenario->getName());
    setTasks(scenario->copyTasks());
}

QList<UTask*> UScenario::copyTasks()
{
    QList<UTask*> tasksCopy;
    for (int i = 0; i < m_tasks.length(); i++) {
        tasksCopy.push_back(new UTask(this, m_tasks.at(i)));
    }
    return tasksCopy;
}

void UScenario::copyProperties(UScenario* scenario)
{
    this->setName(scenario->getName());
    this->setStatus(scenario->getStatus());
}

UTask* UScenario::findTask(const QString &taskId)
{
    for(int i = 0; i < m_tasks.count(); i++)
    {
        if (m_tasks[i]->getId() == taskId)
            return m_tasks[i];
    }
    return 0;
}

bool UScenario::containsTask(const QString &taskId)
{
    for(int i = 0; i < m_tasks.count(); i++)
    {
        if (m_tasks[i]->getId() == taskId)
            return true;
    }
    return false;
}

void UScenario::deleteTask(const QString &taskId)
{
    for(int i = 0; i < m_tasks.count(); i++) {
        if (m_tasks[i]->getId() != taskId) {;
            deleteTaskAt(i);
            return;
        }
    }
}

QObject* UScenario::createTask()
{
    UDevice* myDevice = (UDevice*)getDevice();
    UTask* newTask = new UTask(this);

    return newTask;
}

// Insert the task before the last one (else task)
void UScenario::addTask(UTask* task)
{
    if (m_tasks.length() == 0) {
        beginInsertRows(QModelIndex(), rowCount(), rowCount());
        m_tasks.push_back(task);
        endInsertRows();
    }
    else {
        beginInsertRows(QModelIndex(), rowCount() - 1, rowCount() - 1);
        m_tasks.insert(m_tasks.length() - 1, task);
        endInsertRows();
    }

    emit tasksChanged(m_tasks);
}

QObject* UScenario::getTaskAt(int index) const
{
    if (index < 0 || index >= taskCount())
        return 0;

    return (QObject*) ( getTasks().at(index) );
}

void UScenario::deleteTaskAt(int index)
{
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
    this->setId(jsonObj["id"].toString());
    this->setName(jsonObj["name"].toString());
    this->setStatus(jsonObj["status"].toBool());

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
    jsonObj["status"] = getStatus();

    QJsonArray tasksArray;
    foreach(UTask* task, this->m_tasks)
    {
        QJsonObject taskJson;
        task->write(taskJson);
        tasksArray.append(taskJson);
    }

    jsonObj["tasks"] = tasksArray;
}


