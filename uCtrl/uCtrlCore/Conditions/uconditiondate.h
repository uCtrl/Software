#ifndef UCONDITIONDATE_H
#define UCONDITIONDATE_H

#include "ucondition.h"

class UConditionDate : public UCondition
{
public:
    UConditionDate();
    UConditionDate(QString type, QString name);

    ~UConditionDate();
};

#endif // UCONDITIONDATE_H
