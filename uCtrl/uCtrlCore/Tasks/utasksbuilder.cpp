#include "utasksbuilder.h"

UTasksBuilder::UTasksBuilder()
{
    IsDirty = false;

    void AddTask();
    {
        IsDirty = true;

    }
    void EditTask();
    {
        IsDirty = true;

    }
    void DeleteTask();
    {
        IsDirty = true;

    }

}
