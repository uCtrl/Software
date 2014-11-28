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
        Not = 0x10,
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
    Q_INVOKABLE UEType type() const;
    Q_INVOKABLE void type(UEType type);
    Q_INVOKABLE UEComparisonType comparisonType() const;
    Q_INVOKABLE void comparisonType(UEComparisonType comparisonType);
    Q_INVOKABLE QString beginValue() const;
    Q_INVOKABLE void beginValue(const QString& beginValue);
    Q_INVOKABLE QString endValue() const;
    Q_INVOKABLE void endValue(const QString& endValue);
    Q_INVOKABLE QString deviceId() const;
    Q_INVOKABLE void deviceId(const QString& deviceId);

private:
    UEType m_type;
    UEComparisonType m_comparisonType;
    QString m_beginValue;
    QString m_endValue;
    QString m_deviceId;
};

#endif // UCONDITION_H
