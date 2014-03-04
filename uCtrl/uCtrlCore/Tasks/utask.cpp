#include "utask.h"



UTask::UTask(QObject *parent):
    QAbstractListModel(parent), m_id(0)
{
    this->addCondition(new UConditionDate("da good type"));
    this->addCondition(new UConditionDate("da good type"));
    printf("au moins une condition de créée");
}

UTask::~UTask()
{
    QList< UCondition* >::iterator cond = m_conditions.begin();

    while( m_conditions.end() != cond )
    {
        // Release the memory associated with the task.
        delete (*cond);
        ++cond;
    }

    m_conditions.clear();
}

void UTask::addCondition(UCondition* cond)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_conditions.append(cond);
    endInsertRows();
}

int UTask::rowCount(const QModelIndex &parent) const
{
    return m_conditions.count();

}

QVariant UTask::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= m_conditions.count())
        return QVariant();

    UCondition* cond = m_conditions[index.row()];
    if (role == typeRole)
        return cond->type();

    return QVariant();
}

QHash<int, QByteArray> UTask::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[typeRole] = "type";
    return roles;
}
