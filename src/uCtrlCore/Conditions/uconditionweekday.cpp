#include "uconditionweekday.h"

UConditionWeekday::UConditionWeekday(QObject* parent, int selectedWeekdays)
    : UCondition(parent, UEConditionType::Day)
    , m_selectedWeekdays(selectedWeekdays)
{
    setComparisonType(UEComparisonType::Equals);
}

UConditionWeekday::UConditionWeekday(QObject* parent, UConditionWeekday* conditionWeekday)
    : UCondition(parent, conditionWeekday)
{
    setSelectedWeekdays(conditionWeekday->getSelectedWeekdays());
}

void UConditionWeekday::read(const QJsonObject &jsonObj) {
    UCondition::read(jsonObj);

    setSelectedWeekdays(jsonObj["selectedWeekdays"].toInt());
}

void UConditionWeekday::write(QJsonObject &jsonObj) const {
    UCondition::write(jsonObj);

    jsonObj["selectedWeekdays"] = getSelectedWeekdays();
}
