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
        QJsonObject scenarioObj = scenario.toObject();
        QString id = scenarioObj["id"].toString();
        ListItem* s = find(id);

        if (s) {
            s->read(scenario.toObject());
        } else {
            s = new UScenario(this);
            s->read(scenario.toObject());
            this->appendRow(s);
        }
    }    
}
