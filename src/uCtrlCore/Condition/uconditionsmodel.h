#ifndef UCONDITIONSMODEL_H
#define UCONDITIONSMODEL_H

#include "Models/listmodel.h"
#include "ucondition.h"

class UConditionsModel : public ListModel
{
    Q_OBJECT

public:
    explicit UConditionsModel(QObject* parent = 0);

    // JsonSerializable
    void write(QJsonObject &jsonObj) const;
    void read(const QJsonObject &jsonObj);
};

#endif // UCONDITIONSMODEL_H
