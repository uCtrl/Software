#include "uconditionweekday.h"

UConditionWeekday::UConditionWeekday(QObject* parent, int selectedWeekdays)
    : UCondition(parent, UEConditionType::Day)
    , m_selectedWeekdays(selectedWeekdays)
{
    setComparisonType(UEComparisonType::Equals);
}

UConditionWeekday::UConditionWeekday(const UConditionWeekday* conditionWeekday)
    : UCondition(conditionWeekday)
{
    setSelectedWeekdays(conditionWeekday->getSelectedWeekdays());
}
