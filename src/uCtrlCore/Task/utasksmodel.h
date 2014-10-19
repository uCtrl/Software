#ifndef UTASKSMODEL_H
#define UTASKSMODEL_H

#include "Models/nestedlistmodel.h"
#include "utask.h"

class UTasksModel : public NestedListModel
{
public:
    UTasksModel(QObject* parent = 0);

    // JsonSerializable
    void write(QJsonObject &jsonObj) const;
    void read(const QJsonObject &jsonObj);
};

#endif // UTASKSMODEL_H
