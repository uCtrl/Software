#include "ucondition.h"
#include "Utility/uniqueidgenerator.h"

UCondition::UCondition()
{
    setId(UniqueIdGenerator::GenerateUniqueId());
}

UCondition::UCondition(const UCondition& condition)
{
    setId(condition.getId());
}
void UCondition::FillObject(json::Object& obj) const
{
    obj["id"] = getId();
}

void UCondition::FillMembers(const json::Object& obj)
{
    setId(obj["id"]);
}
