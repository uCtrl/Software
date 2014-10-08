#include "ucondition.h"
#include "Utility/uniqueidgenerator.h"
#include "uconditiondate.h"
#include "uconditiontime.h"
#include "uconditionweekday.h"
#include "uconditiondevice.h"

UCondition::UCondition(QObject *parent, UCondition::UEConditionType type)
    : QAbstractItemModel(parent), m_conditionParent(parent), m_comparisonType(UEComparisonType::InBetween)
{
    setType(type);
}

UCondition::UCondition(QObject* parent, UCondition* condition)
{
    setId(condition->getId());
    setComparisonType(condition->getComparisonType());
    m_type = condition->getType();
    m_conditionParent = parent;
}

UCondition::~UCondition() {}

UCondition* UCondition::createCondition(QObject *parent, UCondition::UEConditionType type)
{
    switch (type){
    case UEConditionType::Date:
        return new UConditionDate(parent);
    case UEConditionType::Time:
        return new UConditionTime(parent);
    case UEConditionType::Day:
        return new UConditionWeekday(parent, 0);
    case UEConditionType::Device:
        return new UConditionDevice(parent);
    default:
        return new UCondition(parent, UEConditionType::None);
    }
}

UCondition* UCondition::copyCondition(QObject* parent)
{
    switch (getType()) {
    case UEConditionType::Date:
        return new UConditionDate(parent, (UConditionDate*)this);
    case UEConditionType::Time:
        return new UConditionTime(parent, (UConditionTime*)this);
    case UEConditionType::Day:
        return new UConditionWeekday(parent, (UConditionWeekday*)this);
    case UEConditionType::Device:
        return new UConditionDevice(parent, (UConditionDevice*)this);
    default:
        return 0;
    }
}

void UCondition::copyPorperties(UCondition* condition)
{
    this->setComparisonType(condition->getComparisonType());
    this->setType(condition->getType());
}

void UCondition::read(const QJsonObject &jsonObj)
{
    this->setId(jsonObj["id"].toString());
    this->setComparisonType((UEComparisonType)jsonObj["comparisonType"].toInt());
    // Type should be set by Ucondition::createCondition, when calling a sub-class constructor.
}

void UCondition::write(QJsonObject &jsonObj) const
{
    jsonObj["id"] = getId();
    jsonObj["type"] = (int) getType();
    jsonObj["comparisonType"] = (int) getComparisonType();
}
