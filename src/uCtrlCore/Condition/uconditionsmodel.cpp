#include "uconditionsmodel.h"

UConditionsModel::UConditionsModel(QObject* parent) : ListModel(new UCondition, parent)
{
}

void UConditionsModel::write(QJsonObject &jsonObj) const
{
    QJsonArray conditions;
    foreach(ListItem* condition, this->m_items)
    {
        QJsonObject c;
        condition->write(c);
        conditions.append(c);
    }
    jsonObj["conditions"] = conditions;
}

void UConditionsModel::read(const QJsonObject &jsonObj)
{
    QJsonArray conditions = jsonObj["conditions"].toArray();
    foreach(QJsonValue condition, conditions)
    {   
        QJsonObject conditionObj = condition.toObject();
        QString id = conditionObj["id"].toString();
        ListItem* c = find(id);

        if (c) {
            c->read(condition.toObject());
        } else {
            c = new UCondition(this);
            c->read(condition.toObject());
            this->appendRow(c);
        }
    }
}
