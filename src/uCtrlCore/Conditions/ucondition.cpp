#include "ucondition.h"
#include "Utility/uniqueidgenerator.h"
#include "uconditiondate.h"

UCondition::UCondition(QObject *parent, UCondition::UEConditionType type)
    :QAbstractItemModel(parent), m_conditionParent(parent)
{
    setId(UniqueIdGenerator::GenerateUniqueId());
    setType(type);
}

UCondition::~UCondition(){}

QString UCondition::getTypeName()
{
    switch (m_type) {
    case UEConditionType::Date:
        return "Date";
        break;
    case UEConditionType::Day:
        return "Day";
        break;
    case UEConditionType::Time: // fallthrough
    default:
        return "Time";
        break;
    }
}

UCondition::UCondition(const UCondition& condition)
{
    setId(condition.getId());
}

void UCondition::read(const QJsonObject &jsonObj)
{
    this->setId(jsonObj["id"].toInt());
    // Type should be set by Ucondition::createCondition, when calling a sub-class constructor.
}

void UCondition::write(QJsonObject &jsonObj) const
{
    jsonObj["id"] = getId();
    jsonObj["type"] = (int) getType();
}

UCondition *UCondition::createCondition(QObject *parent, UCondition::UEConditionType type)
{
    switch(type){
    case UEConditionType::Date:
        return new UConditionDate(parent);
        break;
    default:
        return new UCondition(parent, UEConditionType::None);
        break;
    }
}
