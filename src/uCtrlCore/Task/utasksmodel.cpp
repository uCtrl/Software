#include "utasksmodel.h"

UTasksModel::UTasksModel(QObject* parent) : NestedListModel(new UTask, parent)
{
}

void UTasksModel::write(QJsonObject &jsonObj) const
{
    QJsonArray tasks;
    foreach(ListItem* task, this->m_items)
    {
        QJsonObject t;
        task->write(t);
        tasks.append(t);
    }
    jsonObj["tasks"] = tasks;
}

void UTasksModel::read(const QJsonObject &jsonObj)
{
    QJsonArray tasks = jsonObj["tasks"].toArray();
    foreach(QJsonValue task, tasks)
    {
        QJsonObject taskObj = task.toObject();
        QString id = taskObj["id"].toString();
        ListItem* t = find(id);

        if (t) {
            t->read(task.toObject());
        } else {
            t = new UTask(this);
            t->read(task.toObject());
            this->appendRow(t);
        }
    }
}
