#include "udevicesmodel.h"

UDevicesModel::UDevicesModel(QObject* parent) : NestedListModel(new UDevice, parent)
{
}
