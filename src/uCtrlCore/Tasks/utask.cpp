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

QObject* UTask::createCondition(int conditionType)
{
    return UCondition::createCondition(this, (UCondition::UEConditionType)conditionType);
}

void UTask::addCondition(UCondition* condition)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_conditions.push_back(condition);
    endInsertRows();

    emit conditionsChanged(m_conditions);
}

QObject* UTask::getConditionAt(int index) const
{
    if (index < 0 || index >= conditionCount())
        return 0;

    return (QObject*) ( m_conditions.at(index) );
}

void UTask::deleteConditionAt(int index)
{
    if (index < 0 || index >= conditionCount())
        return;

    beginRemoveRows(QModelIndex(), index, index);

    QObject* condition = getConditionAt(index);
    delete condition;
    condition = NULL;
    m_conditions.removeAt(index);

    endRemoveRows();

    emit conditionsChanged(m_conditions);
}

void UTask::moveCondition(int indexSource, int indexDestination)
{
    if (indexDestination < 0 || indexDestination >= m_conditions.size())
        return;

    if (indexSource < 0 || indexSource >= m_conditions.size())
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

    emit conditionsChanged(m_conditions);
}

void UTask::read(const QJsonObject &jsonObj)
{
    this->setId(jsonObj["id"].toInt());
    this->setStatus(jsonObj["status"].toString());

    QJsonArray conditionsArray = jsonObj["conditions"].toArray();
    foreach(QJsonValue conditionJson, conditionsArray)
    {
        int conditionType = conditionJson.toObject()["type"].toInt();
        UCondition* c = UCondition::createCondition(this, (UCondition::UEConditionType) conditionType);
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
