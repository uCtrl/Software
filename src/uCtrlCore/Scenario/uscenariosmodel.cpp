#include "uscenariosmodel.h"

UScenariosModel::UScenariosModel(QObject* parent) : NestedListModel(new UScenario, parent)
{
}

void UScenariosModel::write(QJsonObject &jsonObj) const
{
    QJsonArray scenarios;
    foreach(ListItem* scenario, this->m_items)
    {
        QJsonObject s;
        scenario->write(s);
        scenarios.append(s);
    }
    jsonObj["scenarios"] = scenarios;
}

void UScenariosModel::read(const QJsonObject &jsonObj)
{
    QJsonArray scenarios = jsonObj["scenarios"].toArray();
    foreach(QJsonValue scenario, scenarios)
    {
        UScenario* s = new UScenario(this);
        s->read(scenario.toObject());
        this->appendRow(s);
    }
}
