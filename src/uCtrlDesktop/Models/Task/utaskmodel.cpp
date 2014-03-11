#include "utaskmodel.h"

UTaskModel::UTaskModel(const UTask* task, QObject *parent)
    : QAbstractListModel(parent)
{
    m_task = task;
}


UTaskModel::~UTaskModel()
{
}

void UTaskModel::addCondition(const UCondition* cond)
{
}

int UTaskModel::rowCount(const QModelIndex & parent) const {
    return m_task->conditions().size();
}

QVariant UTaskModel::data(const QModelIndex & index, int role) const {
    if (index.row() < 0 || index.row() >= m_task->conditions().size())
        return QVariant();

    const UCondition* cond = &m_task->conditions().at(index.row());
    if (role == idRole){
        return cond->id();
    }
    return QVariant();
}

QHash<int, QByteArray> UTaskModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[idRole] = "id";
    return roles;
}

const UCondition *UTaskModel::getConditionAt(const QString &index) const
{
    const UCondition* cond = &m_task->conditions().at(index.toInt());
    if (cond) {
        return cond;
    }
    return 0;
}

