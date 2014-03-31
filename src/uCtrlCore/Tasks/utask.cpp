#include "utask.h"
#include "Utility/uniqueidgenerator.h"

UTask::UTask(QObject* parent) : QAbstractListModel(parent), m_scenario(parent)
{
    setId(UniqueIdGenerator::GenerateUniqueId());
}

UTask::UTask(const UTask* task)
{
    setId(task->getId());
    setStatus(task->getStatus());
    setConditions(task->getConditions());
}

UTask::~UTask()
{
    m_conditions.clear();
}

QObject* UTask::createCondition()
{
    return new UCondition(this);
}

void UTask::addCondition(UCondition* condition)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_conditions.push_back(condition);
    endInsertRows();
}

QObject* UTask::getConditionAt(int index) const
{
    if (index < 0 || index >= taskCount())
        return 0;

    return (QObject*) ( m_conditions.at(index) );
}

void UTask::deleteConditionAt(int index)
{
    if (index < 0 || index >= taskCount())
        return;

    beginRemoveRows(QModelIndex(), index, index);

    QObject* condition = getConditionAt(index);
    delete condition;
    condition = NULL;
    m_conditions.removeAt(index);

    endRemoveRows();
}

void UTask::moveCondition(int indexSource, int indexDestination)
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

    m_conditions.move(indexSource, indexDestination);

    endMoveRows();
}

void UTask::read(const QJsonObject &jsonObj)
{
    this->setId(jsonObj["id"].toInt());
    this->setStatus(jsonObj["status"].toString());

    QJsonArray conditionsArray = jsonObj["conditions"].toArray();
    foreach(QJsonValue conditionJson, conditionsArray)
    {
        UCondition* c = new UCondition(this);
        c->read(conditionJson.toObject());
        this->m_conditions.append(c);
    }
}

void UTask::write(QJsonObject &jsonObj) const
{
    jsonObj["id"] = getId();
    jsonObj["status"] = getStatus();

    QJsonArray conditionsArray;
    foreach(UCondition* condition, this->m_conditions)
    {
        QJsonObject conditionJson;
        condition->write(conditionJson);
        conditionsArray.append(conditionJson);
    }

    jsonObj["conditions"] = conditionsArray;
}
