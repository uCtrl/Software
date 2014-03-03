#ifndef UCONDITIONTIME_H
#define UCONDITIONTIME_H

#include "ucondition.h"

class UConditionTime : public UCondition
{
public:
    UConditionTime(QString type, QString name);
    UConditionTime();
    ~UConditionTime(){}
};

#endif // UCONDITIONTIME_H
