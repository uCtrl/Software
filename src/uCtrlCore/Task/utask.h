#ifndef UTASK_H
#define UTASK_H

#include "Models/nestedlistitem.h"
#include "Models/nestedlistmodel.h"
#include "Condition/ucondition.h"

class UTask : public NestedListItem
{
    Q_OBJECT

    enum TaskRoles
    {
        idRole = Qt::UserRole + 1,
        suspendedRole,
        nameRole,
        statusRole
    };

public:
    explicit UTask(QObject *parent = 0);
    ~UTask();

    // NestedListItem
    QVariant data(int role) const;
    bool setData(const QVariant &value, int role);
    QHash<int, QByteArray> roleNames() const;
    ListModel* nestedModel() const;

    // Properties
    inline QString id() const { return m_id; }
    inline void id(const QString& id) { m_id = id; emit dataChanged(); }
    inline bool suspended() const { return m_suspended; }
    inline void suspended(bool suspended) { m_suspended = suspended; emit dataChanged(); }
    inline QString name() const { return m_name; }
    inline void name(const QString& name) { m_name = name; emit dataChanged(); }
    inline bool status() const { return m_status; }
    inline void status(bool status) { m_status = status; emit dataChanged(); }

private:
    QString m_id;
    bool m_suspended;
    QString m_name;
    bool m_status;
    ListModel* m_conditions;
};

#endif // UTASK_H
