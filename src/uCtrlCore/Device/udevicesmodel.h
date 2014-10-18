#ifndef UDEVICESMODEL_H
#define UDEVICESMODEL_H

#include "Models/nestedlistmodel.h"
#include "udevice.h"

class UDevicesModel : public NestedListModel
{
public:
    UDevicesModel(QObject* parent = 0);
};

#endif // UDEVICESMODEL_H
