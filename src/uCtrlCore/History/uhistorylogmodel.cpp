#include "uhistorylogmodel.h"
#include "QDebug"

UHistoryLogModel::UHistoryLogModel(QObject* parent) : ListModel(new UHistoryLog, parent)
{
}

void UHistoryLogModel::write(QJsonObject &jsonObj) const
{
    QJsonArray history;
    foreach(ListItem* event, this->m_items)
    {
        QJsonObject s;
        event->write(s);
        history.append(s);
    }
    jsonObj["history"] = history;
}

void UHistoryLogModel::read(const QJsonObject &jsonObj)
{
    QJsonArray history = jsonObj["history"].toArray();
    foreach(QJsonValue event, history)
    {
        ListItem* s = new UHistoryLog(this);
        s->read(event.toObject());
        this->appendRow(s);
    }

    qDebug() << "CORE -- Reading logs";

    emit logsReceived();
}
