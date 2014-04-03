#ifndef UCONDITIONDATE_H
#define UCONDITIONDATE_H

#include "ucondition.h"
#include <QDateTime>

class UConditionDate: public UCondition
{
    Q_OBJECT
    Q_ENUMS(UEConditionDateType)
    Q_ENUMS(UEComparisonType)
public:
    enum class UEConditionDateType: int
    {
        DDMMYYYY, // Specific date (ex : June 02, 2014 to Jun 17, 2014)
        DDMM, // Specific date for any year (ex : Jun 02 to Jun 17)
        MM // Months for any year (ex : May to September)
    };

    enum class UEComparisonType: int {
        None = 0,
        GreaterThan = 0x1,
        LesserThan = 0x2,
        Equals = 0x4,
        InBetween = 0x8
    };

    Q_PROPERTY(UEConditionDateType dateType READ getDateType WRITE setDateType )
    Q_PROPERTY(QDate beginDate READ getBeginDate WRITE setBeginDate NOTIFY beginDateChanged )
    Q_PROPERTY(QDate endDate READ getEndDate WRITE setEndDate  NOTIFY endDateChanged)
    Q_PROPERTY(UEComparisonType comparisonType READ getComparisonType WRITE setComparisonType)
    UConditionDate(QObject* parent, UEConditionDateType type, QDate beginDate = QDate(), QDate endDate = QDate());
    UConditionDate(QObject* parent);

    UEConditionDateType getDateType() const { return m_dateType;  }

    QDate getBeginDate() const {
        return m_beginDate; }
    QDate getEndDate() const { return m_endDate; }
    UEComparisonType getComparisonType() const { return m_comparisonType; }

public slots:
    void setDateType(UEConditionDateType arg) { m_dateType = arg; }
    void setBeginDate(QDate arg) { m_beginDate = arg; }
    void setEndDate(QDate arg) { m_endDate = arg; }
    void setComparisonType(UEComparisonType arg) { m_comparisonType = arg; }

private:
    UEConditionDateType m_dateType;
    QDate m_beginDate;
    QDate m_endDate;
    UEComparisonType m_comparisonType;

public:
    virtual void read(const QJsonObject &jsonObj);
    virtual void write(QJsonObject &jsonObj) const;
signals:
    void beginDateChanged(QDate arg);
    void endDateChanged(QDate arg);
};

#endif // UCONDITIONDATE_H
