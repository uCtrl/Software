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
    inline int type() const;
    inline void type(int type);
    inline int comparisonType() const;
    inline void comparisonType(int comparisonType);
    inline QString beginValue() const;
    inline void beginValue(const QString& beginValue);
    inline QString endValue() const;
    inline void endValue(const QString& endValue);
    inline QString deviceId() const;
    inline void deviceId(const QString& deviceId);

private:
    int m_type;
    int m_comparisonType;
    QString m_beginValue;
    QString m_endValue;
    QString m_deviceId;
};

#endif // UCONDITION_H
