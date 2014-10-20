#ifndef UTASK_H
#define UTASK_H

#include "Models/nestedlistitem.h"
#include "Models/nestedlistmodel.h"
#include "Condition/uconditionsmodel.h"

class UTask : public NestedListItem
{
    Q_OBJECT

    enum TaskRoles
    {
        idRole = Qt::UserRole + 1,
        valueRole,
        lastUpdatedRole,
        enabledRole
    };

public:
    explicit UTask(QObject *parent = 0);
    ~UTask();

    // NestedListItem
    QVariant data(int role) const;
    bool setData(const QVariant &value, int role);
    QHash<int, QByteArray> roleNames() const;
    ListModel* nestedModel() const;

    // JsonSerializable
    void write(QJsonObject &jsonObj) const;
    void read(const QJsonObject &jsonObj);

    // Properties
    inline QString value() const { return m_value; }
    inline void value(const QString& value) { m_value = value; emit dataChanged(); }

private:
    QString m_value;
    ListModel* m_conditions;
};

#endif // UTASK_H
