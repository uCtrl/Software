#ifndef UHISTORYLOGMODEL_H
#define UHISTORYLOGMODEL_H

#include "Models/nestedlistmodel.h"
#include "History/uhistorylog.h"

class UHistoryLogModel : public ListModel
{
    Q_OBJECT

public:
    explicit UHistoryLogModel(QObject* parent = 0);

    // JsonSerializable
    void write(QJsonObject &jsonObj) const;
    void read(const QJsonObject &jsonObj);

    Q_INVOKABLE void setOnReceivedCallback(const QJSValue& callback);

private:
    QJSValue m_onReceivedCallback;
};

#endif // UHISTORYLOGMODEL_H
