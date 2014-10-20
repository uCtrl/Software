#ifndef USCENARIOSMODEL_H
#define USCENARIOSMODEL_H

#include "Models/nestedlistmodel.h"
#include "uscenario.h"

class UScenariosModel : public NestedListModel
{
public:
    UScenariosModel(QObject* parent = 0);

    // JsonSerializable
    void write(QJsonObject &jsonObj) const;
    void read(const QJsonObject &jsonObj);
};

#endif // USCENARIOSMODEL_H
