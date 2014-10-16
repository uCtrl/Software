#ifndef UCONDITION_H
#define UCONDITION_H

#include "Models/listitem.h"

class UCondition : public ListItem
{
    Q_OBJECT

    enum ConditionRoles
    {
        idRole = Qt::UserRole + 1
    };

public:
    explicit UCondition(QObject *parent = 0);
    ~UCondition();

    // NestedListItem
    QVariant data(int role) const;
    bool setData(const QVariant &value, int role);
    QHash<int, QByteArray> roleNames() const;

    // Properties
    inline QString id() const { return m_id; }
    inline void id(const QString& id) { m_id = id; emit dataChanged(); }

private:
    QString m_id;
};

#endif // UCONDITION_H
