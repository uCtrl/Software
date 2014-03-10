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
    return m_task->conditionCount();
}

QVariant UTaskModel::data(const QModelIndex & index, int role) const {
    if (index.row() < 0 || index.row() >= m_task->conditionCount())
        return QVariant();

    UCondition* cond = m_task->conditionAt(index.row());
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

UCondition *UTaskModel::getConditionAt(const QString &index) const
{
    UCondition *cond = m_task->conditionAt(index.toInt());
    if (cond) {
        return cond;
    }
    return 0;
}

