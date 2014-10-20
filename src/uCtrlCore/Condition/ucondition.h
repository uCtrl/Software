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
    inline int type() const { return m_type; }
    inline void type(int type) { m_type = type; emit dataChanged(); }
    inline int comparisonType() const { return m_type; }
    inline void comparisonType(int comparisonType) { m_comparisonType = comparisonType; emit dataChanged(); }
    inline QString beginValue() const { return m_beginValue; }
    inline void beginValue(const QString& beginValue) { m_beginValue = beginValue; emit dataChanged(); }
    inline QString endValue() const { return m_endValue; }
    inline void endValue(const QString& endValue) { m_endValue = endValue; emit dataChanged(); }
    inline QString deviceId() const { return m_deviceId; }
    inline void deviceId(const QString& deviceId) { m_deviceId = deviceId; emit dataChanged(); }
    inline QString deviceValue() const { return m_deviceValue; }
    inline void deviceValue(const QString& deviceValue) { m_deviceValue = deviceValue; emit dataChanged(); }

private:
    int m_type;
    int m_comparisonType;
    QString m_beginValue;
    QString m_endValue;
    QString m_deviceId;
    QString m_deviceValue;
};

#endif // UCONDITION_H
