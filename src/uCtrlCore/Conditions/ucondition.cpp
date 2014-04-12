#include "ucondition.h"
#include "Utility/uniqueidgenerator.h"
#include "uconditiondate.h"
#include "uconditiontime.h"
#include "uconditionweekday.h"

UCondition::UCondition(QObject *parent, UCondition::UEConditionType type)
    :QAbstractItemModel(parent), m_conditionParent(parent), m_comparisonType(UEComparisonType::InBetween)
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
    this->setComparisonType((UEComparisonType)jsonObj["comparisonType"].toInt());
    // Type should be set by Ucondition::createCondition, when calling a sub-class constructor.
}

void UCondition::write(QJsonObject &jsonObj) const
{
    jsonObj["id"] = getId();
    jsonObj["type"] = (int) getType();
    jsonObj["comparisonType"] = (int) getComparisonType();
}

UCondition* UCondition::createCondition(QObject *parent, UCondition::UEConditionType type)
{
    switch(type){
    case UEConditionType::Date:
        return new UConditionDate(parent);
    case UEConditionType::Time:
        return new UConditionTime(parent);
    case UEConditionType::Day:
        return new UConditionWeekday(parent, 0);
    default:
        return new UCondition(parent, UEConditionType::None);
    }
}
