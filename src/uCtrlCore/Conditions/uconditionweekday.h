#ifndef UCONDITIONWEEKDAY_H
#define UCONDITIONWEEKDAY_H

#include "ucondition.h"
#include <QDate>

class UConditionWeekday : public UCondition
{
    Q_OBJECT

public:
    Q_PROPERTY(int selectedWeekdays READ getSelectedWeekdays WRITE setSelectedWeekdays NOTIFY selectedWeekdaysChanged)

    Q_ENUMS(UEWeekday)

    enum class UEWeekday : int {
        Monday = 1,
        Tuesday = 2,
        Wednesday = 4,
        Thursday = 8,
        Friday = 16,
        Saturday = 32,
        Sunday = 64
    };

    UConditionWeekday() { setComparisonType(UEComparisonType::Equals);}
    UConditionWeekday(QObject* parent, int selectedWeekdays = 0);
    UConditionWeekday(const UConditionWeekday* conditionWeekday);

    int getSelectedWeekdays() const { return m_selectedWeekdays; }

public slots:
    void setSelectedWeekdays(int arg)
    {
        if (m_selectedWeekdays != arg) {
            m_selectedWeekdays = arg;
            emit selectedWeekdaysChanged(arg);
        }
    }

signals:
    void selectedWeekdaysChanged(int arg);

private:
    int m_selectedWeekdays;
};

#endif // UCONDITIONWEEKDAY_H
