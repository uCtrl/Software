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
    enum class UEConditionType {
        None = -1,
        Date = 1,
        Day,
        Time
    };

    Q_PROPERTY(int id READ getId WRITE setId)
    Q_PROPERTY(QObject* conditionParent READ getConditionParent)
    Q_PROPERTY(UEConditionType type READ getType WRITE setType)

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

private:
    int m_id;
    QObject* m_conditionParent;
    UEConditionType m_type;

    // QAbstractItemModel interface
public:
    QModelIndex index(int row, int column, const QModelIndex &parent) const {return QModelIndex(); }
    QModelIndex parent(const QModelIndex &child) const{return QModelIndex(); }
    int rowCount(const QModelIndex &parent) const {return 0; }
    int columnCount(const QModelIndex &parent) const {return 0; }
    QVariant data(const QModelIndex &index, int role) const{return QVariant(); }
};

#endif // UCONDITION_H
