#ifndef UCONDITION_H
#define UCONDITION_H

#include "QAbstractItemModel"
#include <Serialization/jsonserializable.h>


// TODO: Use QDateTime + Clean everything up in here!
class UCondition : public QAbstractItemModel, public JsonSerializable
{
    Q_OBJECT
public:
    Q_ENUMS(UEConditionType)
    Q_ENUMS(UEComparisonType)

    enum class UEConditionType {
        None = -1,
        Date = 1,
        Day,
        Time
    };

    enum class UEComparisonType: int {
        None = 0,
        GreaterThan = 0x1,
        LesserThan = 0x2,
        Equals = 0x4,
        InBetween = 0x8
    };

    Q_PROPERTY(int id READ getId WRITE setId)
    Q_PROPERTY(QObject* conditionParent READ getConditionParent)
    Q_PROPERTY(UEConditionType type READ getType WRITE setType)
    Q_PROPERTY(UEComparisonType comparisonType READ getComparisonType WRITE setComparisonType NOTIFY comparisonTypeChanged)

    UCondition() : m_comparisonType(UEComparisonType::InBetween){}
    UCondition (QObject* parent, UEConditionType type );
    UCondition(const UCondition& condition);
    ~UCondition();

    int getId() const { return m_id; }
    UEConditionType getType() const { return m_type; }
    Q_INVOKABLE QString getTypeName();

    void read(const QJsonObject &jsonObj);
    void write(QJsonObject &jsonObj) const;

    QObject* getConditionParent() const { return m_conditionParent;  }
    static UCondition* createCondition(QObject* parent, UEConditionType type);

public slots:
    void setId(int arg) { m_id = arg; }
    void setType(UEConditionType arg) { m_type = arg; }

    void setComparisonType(UEComparisonType arg)
    {
        if (m_comparisonType != arg) {
            m_comparisonType = arg;
            emit comparisonTypeChanged(arg);
        }
    }

private:
    int m_id;
    QObject* m_conditionParent;
    UEConditionType m_type;

    // QAbstractItemModel interface
    UEComparisonType m_comparisonType;

public:
    QModelIndex index(int row, int column, const QModelIndex &parent) const {return QModelIndex(); }
    QModelIndex parent(const QModelIndex &child) const{return QModelIndex(); }
    int rowCount(const QModelIndex &parent) const {return 0; }
    int columnCount(const QModelIndex &parent) const {return 0; }
    QVariant data(const QModelIndex &index, int role) const{return QVariant(); }

    UEComparisonType getComparisonType() const { return m_comparisonType; }
signals:
    void comparisonTypeChanged(UEComparisonType arg);
};

#endif // UCONDITION_H
