#ifndef UTASK_H
#define UTASK_H
#include "../Conditions/ucondition.h"

class UTask
{
public:
     UTask(const int id): m_id(id){}
     UTask() {}
     ~UTask(){}
     int id() const;

private:
    int m_id;
};

#endif // UTASK_H
