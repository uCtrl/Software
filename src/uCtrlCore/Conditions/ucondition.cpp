#include "ucondition.h"

UCondition::UCondition( QObject* parent ) : QAbstractListModel(parent), m_conditionParent(parent) {}

UCondition::UCondition(const UCondition& condition)
{
    setId(condition.getId());
}

void UCondition::read(const QJsonObject &jsonObj)
{
    this->setId(jsonObj["id"].toInt());
}

void UCondition::write(QJsonObject &jsonObj) const
{
    jsonObj["id"] = getId();
}
