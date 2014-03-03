#ifndef UTASKSBUILDER_H
#define UTASKSBUILDER_H

#include "utask.h"

class UTasksBuilder
{
public:
    UTasksBuilder(const UTask &task);
    ~UTasksBuilder();

    void AddTask();
    void EditTask();
    void DeleteTask();
};

#endif // UTASKSBUILDER_H
