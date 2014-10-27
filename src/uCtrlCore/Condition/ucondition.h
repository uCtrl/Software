#ifndef UCONDITION_H
#define UCONDITION_H

#include "Models/listitem.h"

class UCondition : public ListItem
{
    Q_OBJECT

    enum ConditionRoles
    {
        idRole = Qt::UserRole + 1,
        typeRole,
        comparisonTypeRole,
        beginValueRole,
        endValueRole,
        deviceIdRole,
        deviceValueRole,
        enabledRole,
        lastUpdatedRole
    };

public:
    Q_ENUMS(UEType)
    Q_ENUMS(UEComparisonType)

    enum class UEType: int {
        None = -1,
        Date = 1,
        Day,
        Time,
        Device
    };

    enum class UEComparisonType: int {
        None = 0,
        GreaterThan = 0x1,
        LesserThan = 0x2,
        Equals = 0x4,
        InBetween = 0x8,
        Not = 0x16,
    };

    explicit UCondition(QObject *parent = 0);
    ~UCondition();

    // NestedListItem
    QVariant data(int role) const;
    bool setData(const QVariant &value, int role);
    QHash<int, QByteArray> roleNames() const;

    // JsonSerializable
    void write(QJsonObject &jsonObj) const;
    void read(const QJsonObject &jsonObj);

    // Properties
    UEType type() const;
    void type(UEType type);
    UEComparisonType comparisonType() const;
    void comparisonType(UEComparisonType comparisonType);
    QString beginValue() const;
    void beginValue(const QString& beginValue);
    QString endValue() const;
    void endValue(const QString& endValue);
    QString deviceId() const;
    void deviceId(const QString& deviceId);

private:
    UEType m_type;
    UEComparisonType m_comparisonType;
    QString m_beginValue;
    QString m_endValue;
    QString m_deviceId;
};

#endif // UCONDITION_H
