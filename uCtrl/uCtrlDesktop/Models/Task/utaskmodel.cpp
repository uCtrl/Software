#include "../Task/utaskmodel.h"



UTaskModel::UTaskModel(UTask& task, QObject *parent)
    : QAbstractListModel(parent)
{
    m_task = task;
}


UTaskModel::~UTaskModel()
{
    m_task.~UTask();
}

void UTaskModel::addCondition(UCondition* cond)
{
    m_task.addCondition(cond);
}

int UTaskModel::rowCount(const QModelIndex & parent) const {
    return m_task.conditionCount();
}

QVariant UTaskModel::data(const QModelIndex & index, int role) const {
    if (index.row() < 0 || index.row() >= m_task.conditionCount())
        return QVariant();

    UCondition* cond = m_task.conditionAt(index.row());
    if (role == typeRole){
        // TODO: modify UCondition to return a type
        // return QString(cond->type().c_str()); 
    }
    return QVariant();
}

QHash<int, QByteArray> UTaskModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[typeRole] = "type";
    return roles;
}

