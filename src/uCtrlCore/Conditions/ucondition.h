#ifndef UCONDITION_H
#define UCONDITION_H

#include "QAbstractItemModel"
#include <Serialization/jsonserializable.h>

// TODO: Use QDateTime + Clean everything up in here!
class UCondition : public QAbstractItemModel, public JsonSerializable
{
    Q_OBJECT

    Q_PROPERTY(QString id READ getId WRITE setId)
    Q_PROPERTY(UEConditionType type READ getType WRITE setType NOTIFY typeChanged)
    Q_PROPERTY(UEComparisonType comparisonType READ getComparisonType WRITE setComparisonType NOTIFY comparisonTypeChanged)
    Q_PROPERTY(QObject* conditionParent READ getConditionParent WRITE setConditionParent NOTIFY conditionParentChanged)

    Q_ENUMS(UEConditionType)
    Q_ENUMS(UEComparisonType)

public:
    enum class UEConditionType
    {
        None = -1,
        Date = 1,
        Day,
        Time,
        Device
    };

    enum class UEComparisonType: int
    {
        None = 0,
        GreaterThan = 0x1,
        LesserThan = 0x2,
        Equals = 0x4,
        InBetween = 0x8,
        Not = 0x16,
    };

    UCondition() : m_comparisonType(UEComparisonType::InBetween) {}
    UCondition (QObject* parent, UEConditionType type);
    UCondition(QObject* parent, UCondition* condition);
    ~UCondition();

    QString getId() const
    {
        return m_id;
    }

    UEConditionType getType() const
    {
        return m_type;
    }

    UEComparisonType getComparisonType() const
    {
        return m_comparisonType;
    }

    QObject* getConditionParent() const
    {
        return m_conditionParent;
    }

    static UCondition* createCondition(QObject* parent, UEConditionType type);
    UCondition* copyCondition(QObject* parent);
    void copyPorperties(UCondition* condition);

    QModelIndex index(int row, int column, const QModelIndex &parent) const
    {
        return QModelIndex();
    }

    QModelIndex parent(const QModelIndex &child) const
    {
        return QModelIndex();
    }

    int rowCount(const QModelIndex &parent) const
    {
        return 0;
    }

    int columnCount(const QModelIndex &parent) const
    {
        return 0;
    }

    QVariant data(const QModelIndex &index, int role) const
    {
        return QVariant();
    }

    void read(const QJsonObject &jsonObj);
    void write(QJsonObject &jsonObj) const;

public slots:
    void setId(QString arg)
    {
        m_id = arg;
    }

    void setType(UEConditionType arg)
    {
        if (m_type != arg) {
            m_type = arg;
            emit typeChanged(arg);
        }
    }

    void setComparisonType(UEComparisonType arg)
    {
        if (m_comparisonType != arg) {
            m_comparisonType = arg;
            emit comparisonTypeChanged(arg);
        }
    }

    void setConditionParent(QObject* arg)
    {
        if (m_conditionParent != arg) {
            m_conditionParent = arg;
            setParent(arg);
            emit conditionParentChanged(arg);
        }
    }

signals:
    void typeChanged(UEConditionType arg);
    void comparisonTypeChanged(UEComparisonType arg);
    void conditionParentChanged(QObject* arg);

private:
    QString m_id;
    QObject* m_conditionParent;
    UEConditionType m_type;
    UEComparisonType m_comparisonType;
};

#endif // UCONDITION_H
