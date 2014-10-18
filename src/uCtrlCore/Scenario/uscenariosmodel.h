#ifndef USCENARIOSMODEL_H
#define USCENARIOSMODEL_H

#include "Models/nestedlistmodel.h"
#include "uscenario.h"

class UScenariosModel : public NestedListModel
{
public:
    UScenariosModel(QObject* parent = 0);
};

#endif // USCENARIOSMODEL_H
