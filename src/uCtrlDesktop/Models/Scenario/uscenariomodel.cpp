#include "uscenariomodel.h"

UScenarioModel::UScenarioModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

UScenarioModel::UScenarioModel(const UScenario* scenario, QObject *parent)
    : QAbstractListModel(parent)
{
    m_scenario = scenario;
}

UScenarioModel::UScenarioModel(const UScenarioModel& scenarioModel, QObject *parent)
    : QAbstractListModel(parent)
{
    this->m_scenarioBuilder = scenarioModel.m_scenarioBuilder;
    this->m_scenario = scenarioModel.m_scenario;
}

UScenarioModel::UScenarioModel(const UScenarioBuilder* scenarioBuilder, QObject *parent)
    : QAbstractListModel(parent)
    , m_scenarioBuilder(scenarioBuilder)
    , m_scenario(scenarioBuilder->getScenario())
{
}

UScenarioModel::~UScenarioModel()
{
}

QString UScenarioModel::name() {
    QString string = QString::fromStdString(m_scenario->m_name);
    return string;
}

void UScenarioModel::setName(QString newName) {}

int UScenarioModel::rowCount(const QModelIndex & parent) const {
    return m_scenario->tasks().size();
}

QVariant UScenarioModel::data(const QModelIndex & index, int role) const {
    if (index.row() < 0 || index.row() >= m_scenario->tasks().size())
        return QVariant();
    const UTask* task = &m_scenario->tasks().at(index.row());
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
    const UTask *task = &m_scenario->tasks().at(index.toInt());
    if (task) {
        return new UTaskModel(task);
    }
    return 0;
}

QList<QObject*> UScenarioModel::getTasks() const
{
    QList<QObject*> list;
    for (int i=0; i<m_scenario->m_tasks.size(); i++) {
        list.append(new UTaskModel(&m_scenario->tasks().at(i)));
    }

    return list;
}
