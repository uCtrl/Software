#ifndef USCENARIOSMODEL_H
#define USCENARIOSMODEL_H

#include "Models/nestedlistmodel.h"
#include "uscenario.h"

class UScenariosModel : public NestedListModel
{
    Q_OBJECT

public:
    explicit UScenariosModel(QObject* parent = 0);
    Q_INVOKABLE QObject* createNewScenario();

    // JsonSerializable
    void write(QJsonObject &jsonObj) const;
    void read(const QJsonObject &jsonObj);
};

#endif // USCENARIOSMODEL_H
