#include "uscenario.h"

UScenario::UScenario(QObject* parent) : NestedListItem(parent)
{
    m_tasks = new UTasksModel(this);
}

UScenario::~UScenario()
{
}

QVariant UScenario::data(int role) const
{
    switch (role)
    {
    case idRole:
        return id();
    case nameRole:
        return name();
    case enabledRole:
        return enabled();
    case lastUpdatedRole:
        return lastUpdated();
    default:
        return QVariant();
    }
}

bool UScenario::setData(const QVariant& value, int role)
{
    switch (role)
    {
    case idRole:
        id(value.toString());
        break;
    case nameRole:
        name(value.toString());
        break;
    case enabledRole:
        enabled(value.toBool());
        break;
    case lastUpdatedRole:
        lastUpdated(value.toDouble());
        break;
    default:
        return false;
    }
    return true;
}

QHash<int, QByteArray> UScenario::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[idRole] = "id";
    roles[nameRole] = "name";
    roles[enabledRole] = "isEnabled";
    roles[lastUpdatedRole] = "lastUpdated";

    return roles;
}

ListModel* UScenario::nestedModel() const
{
    return m_tasks;
}

void UScenario::write(QJsonObject &jsonObj) const
{
    jsonObj["id"] = this->id();
    jsonObj["name"] = this->name();
    jsonObj["enabled"] = this->enabled();
    jsonObj["lastUpdated"] = this->lastUpdated();

    QJsonObject tasks;
    m_tasks->write(tasks);
    jsonObj["tasks"] = tasks;
}

void UScenario::read(const QJsonObject &jsonObj)
{
    this->id(jsonObj["id"].toString());
    this->name(jsonObj["name"].toString());
    this->enabled(jsonObj["enabled"].toBool());
    this->lastUpdated(jsonObj["lastUpdated"].toString().toDouble());

    readTasks(jsonObj);
}

void UScenario::readTasks(const QJsonObject &jsonObj)
{
    m_tasks->read(jsonObj);
}

QString UScenario::name() const
{
    return m_name;
}

void UScenario::name(const QString &name)
{
    if (m_name != name) {
        m_name = name;
        emit dataChanged();
    }
}
