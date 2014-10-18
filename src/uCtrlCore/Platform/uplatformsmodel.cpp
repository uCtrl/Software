#include "uplatformsmodel.h"

UPlatformsModel::UPlatformsModel(QObject* parent) : NestedListModel(new UPlatform, parent)
{
}
