#ifndef UCONDITIONBUILDER_H
#define UCONDITIONBUILDER_H

class UConditionBuilder
{
public:
    UConditionBuilder();
    ~UConditionBuilder();

    void AddCondition();
    void EditCondition();
    void DeleteCondition();

private:
    bool IsDirty;
};

#endif // UCONDITIONBUILDER_H
