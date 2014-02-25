#include "uconditionbuilder.h"

UConditionBuilder::UConditionBuilder()
{
    IsDirty = false;

    void AddCondition();
    {
        IsDirty = true;

    }
    void EditCondition();
    {
        IsDirty = true;

    }
    void DeleteCondition();
    {
        IsDirty = true;

    }

}
