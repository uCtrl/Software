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
