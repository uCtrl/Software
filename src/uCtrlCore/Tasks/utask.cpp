#include "utask.h"
#include "Utility/uniqueidgenerator.h"
#include "System/usystem.h"

UTask::UTask(QObject* parent) : QAbstractListModel(parent), m_scenario(parent)
{
}

UTask::UTask(QObject* parent, const QString& id) : QAbstractListModel(parent), m_scenario(parent)
{
    setId(id);
}

UTask::UTask(QObject* parent, UTask* task) : QAbstractListModel(parent)
{
    setId(task->getId());
    setConditions(task->copyConditions());
    setScenario(parent);
}

UTask::~UTask()
{
    foreach(UCondition* condition, m_conditions) {
        delete condition;
    }
    m_conditions.clear();
}

QList<UCondition*> UTask::copyConditions() {
    QList<UCondition*> conditionsCopy;
    for (int i = 0; i < m_conditions.length(); i++) {
        UCondition* tmpCondition = m_conditions.at(i);
        conditionsCopy.push_back(tmpCondition->copyCondition(this));
    }
    return conditionsCopy;
}

UCondition* UTask::findCondition(const QString &conditionId)
{
    for(int i = 0; i < m_conditions.count(); i++)
    {
        if (m_conditions[i]->getId() == conditionId)
            return m_conditions[i];
    }
    return 0;
}

bool UTask::containsCondition(const QString &conditionId)
{
    for(int i = 0; i < m_conditions.count(); i++)
    {
        if (m_conditions[i]->getId() == conditionId)
            return true;
    }
    return false;
}

void UTask::deleteCondition(const QString &conditionId)
{
    for(int i = 0; i < m_conditions.count(); i++) {
        if (m_conditions[i]->getId() != conditionId) {;
            deleteConditionAt(i);
            return;
        }
    }
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

QObject* UTask::getAllDevices()
{
    return USystem::Instance()->getAllDevices();
}

void UTask::copyProperties(UTask *task)
{
    this->setStatus(task->getStatus());
}

void UTask::read(const QJsonObject &jsonObj)
{
    this->setId(jsonObj["id"].toString());
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
