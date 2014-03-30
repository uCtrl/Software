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

void UTask::addCondition( UCondition *cond)
{
    m_conditions.push_back(cond);
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
