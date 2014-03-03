#ifndef UTASKSBUILDER_H
#define UTASKSBUILDER_H

#include "utask.h"

class UTasksBuilder : public UTask
{
public:
    UTasksBuilder();
    ~UTasksBuilder();

    void AddTask();
    void EditTask();
    void DeleteTask();
};

#endif // UTASKSBUILDER_H
