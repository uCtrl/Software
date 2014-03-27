#ifndef UCONDITION_H
#define UCONDITION_H

#include <Serialization/jsonserializable.h>
#include <QAbstractListModel>
#include <QObject>

namespace UEComparisonPossible
{
    enum Type
    {
        GreaterThan = 0x1,
        LesserThan = 0x2,
        Equals = 0x4,
        InBetween = 0x8
    };
}

namespace UEConditionType
{
    enum Type
    {
        Date = 1,
        Day = 2,
        Time = 3
    };
}

// TODO: Use QDateTime + Clean everything up in here!
class UCondition : public QAbstractListModel, public JsonSerializable
{
    Q_OBJECT

    Q_PROPERTY(int id READ getId WRITE setId)
    //Q_PROPERTY(UEConditionType::Type conditionType READ getConditionType WRITE setConditionType)
    //Q_PROPERTY(UEComparisonPossible::Type currentComparaisonType READ getCurrentComparaisonType WRITE setCurrentComparaisonType)

public:
    UCondition(QObject* parent);
    UCondition(const UCondition& condition);

    //virtual int getComparisonPossible() { return 0; }
    //virtual void  setValue1(void* value) {}
    //virtual void setValue2(void* value) {}

    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const { return 1; }
    virtual QVariant data(const QModelIndex &index, int role) const { return QVariant(); }

    int getId() const { return m_id; }
    //UEConditionType::Type getConditionType() const { return m_conditionType; }
    //UEComparisonPossible::Type getCurrentComparaisonType() const { return m_currentComparaisonType; }

    void read(const QJsonObject &jsonObj);
    void write(QJsonObject &jsonObj) const;

public slots:
    void setId(int arg) { m_id = arg; }
    //void setConditionType(UEConditionType::Type arg) { m_conditionType = arg; }
    //void setCurrentComparaisonType(UEComparisonPossible::Type arg) { m_currentComparaisonType = arg; }

private:
    int m_id;
    //UEConditionType::Type m_conditionType;
    //UEComparisonPossible::Type m_currentComparaisonType;
};
#endif // UCONDITION_H
