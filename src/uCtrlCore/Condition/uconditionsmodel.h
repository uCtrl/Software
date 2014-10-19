#ifndef UCONDITIONSMODEL_H
#define UCONDITIONSMODEL_H

#include "Models/listmodel.h"
#include "ucondition.h"

class UConditionsModel : public ListModel
{
public:
    UConditionsModel(QObject* parent);

    // JsonSerializable
    void write(QJsonObject &jsonObj) const;
    void read(const QJsonObject &jsonObj);
};

#endif // UCONDITIONSMODEL_H
