#ifndef UCONDITIONTIME_H
#define UCONDITIONTIME_H

#include "ucondition.h"

class UConditionTime : public UCondition
{
public:
    UConditionTime();
    UConditionTime(QString type, QString name);
};

#endif // UCONDITIONTIME_H
