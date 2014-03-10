#include "uscenariomodel.h"
#include "../Models/Task/utaskmodel.h"

UScenarioModel::UScenarioModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

UScenarioModel::UScenarioModel(const UScenarioBuilder* scenarioBuilder, QObject *parent)
    : QAbstractListModel(parent)
    , m_scenarioBuilder(scenarioBuilder)
    , m_scenario(scenarioBuilder->getScenario())
{
    //m_scenario = scenarioBuilder->getScenario();
}

UScenarioModel::~UScenarioModel()
{
}

int UScenarioModel::rowCount(const QModelIndex & parent) const {
    return m_scenario->taskCount();
}

QVariant UScenarioModel::data(const QModelIndex & index, int role) const {
    if (index.row() < 0 || index.row() >= m_scenario->taskCount())
        return QVariant();
    const UTask* task = m_scenario->taskAt(index.row());
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

QObject* UScenarioModel::getTaskAt(const QString &index) const
{
    const UTask *task = m_scenario->taskAt(index.toInt());
    if (task) {
        return new UTaskModel(task);
    }
    return 0;
}
