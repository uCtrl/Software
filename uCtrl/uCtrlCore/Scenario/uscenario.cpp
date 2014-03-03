#include "uscenario.h"

UScenario::UScenario(QObject *parent)
    : QAbstractListModel(parent)
{

}

UScenario::~UScenario()
{

}


void UScenario::addTask(const UTask &task)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_tasks << task;
    endInsertRows();
}

int UScenario::rowCount(const QModelIndex & parent) const {
    return m_tasks.count();
}

QVariant UScenario::data(const QModelIndex & index, int role) const {
    if (index.row() < 0 || index.row() >= m_tasks.count())
        return QVariant();

    const UTask &task = m_tasks[index.row()];
    if (role == IdRole)
        return task.id();

    return QVariant();
}

//![0]
QHash<int, QByteArray> UScenario::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    return roles;
}
//![0]

