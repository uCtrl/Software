#include "utasksmodel.h"

UTasksModel::UTasksModel(QObject* parent) : NestedListModel(new UTask, parent)
{
}
