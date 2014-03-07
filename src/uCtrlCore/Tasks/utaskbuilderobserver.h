#ifndef UTASKBUILDEROBSERVER_H
#define UTASKBUILDEROBSERVER_H

#include "utask.h"

class UTaskBuilderObserver
{
public:
    UTaskBuilderObserver();
    virtual void onTaskUpdated(const UTask& updatedTask) = 0;
};

#endif // UTASKBUILDEROBSERVER_H
