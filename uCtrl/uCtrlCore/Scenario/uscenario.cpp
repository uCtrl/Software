#include "uscenario.h"

UScenario::UScenario(QObject *parent)
    : QAbstractListModel(parent)
{
}


UScenario::~UScenario()
{
    QList< UTask* >::iterator task = m_tasks.begin();

    while( m_tasks.end() != task )
    {
        // Release the memory associated with the task.
        delete (*task);
        ++task;
    }

    m_tasks.clear();
}

void UScenario::addTask(UTask* task)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_tasks.append(task);
    endInsertRows();
}

int UScenario::rowCount(const QModelIndex & parent) const {
    return m_tasks.count();
}

QVariant UScenario::data(const QModelIndex & index, int role) const {
    if (index.row() < 0 || index.row() >= m_tasks.count())
        return QVariant();

    UTask* task = m_tasks[index.row()];
    if (role == IdRole){
        return task->id();
    }
}

QHash<int, QByteArray> UScenario::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    return roles;
}

QObject *UScenario::GetTasks(const QString &id) const
{
    UTask *task = static_cast<UTask*>(m_tasks.at(id.toInt()));
    if (task) {
        return task;
    }
    return 0;
}


