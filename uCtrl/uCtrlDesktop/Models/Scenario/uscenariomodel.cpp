#include "uscenariomodel.h"

UScenarioModel::UScenarioModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

UScenarioModel::UScenarioModel(UScenario& scenario, QObject *parent)
    : QAbstractListModel(parent)
{
    m_scenario = scenario;
}


UScenarioModel::~UScenarioModel()
{
    m_scenario.~UScenario();
}

void UScenarioModel::addTask(UTask* task)
{
    m_scenario.addTask(task);
}

int UScenarioModel::rowCount(const QModelIndex & parent) const {
    return m_scenario.taskCount();
}

QVariant UScenarioModel::data(const QModelIndex & index, int role) const {
    if (index.row() < 0 || index.row() >= m_scenario.taskCount())
        return QVariant();
    UTask* task = m_scenario.taskAt(index.row());
    if (role == IdRole){
        return task->id();
    }
    if (role == StatusRole){
        return task->status().c_str();
    }
    return QVariant();
}

QHash<int, QByteArray> UScenarioModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[StatusRole] = "taskStatus";
    return roles;
}


