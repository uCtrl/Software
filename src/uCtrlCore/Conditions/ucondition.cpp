#include "ucondition.h"
#include "Utility/uniqueidgenerator.h"

UCondition::UCondition()
{
    this->m_id = UniqueIdGenerator::GenerateUniqueId();
}

UCondition::UCondition(const UCondition& condition)
{
    this->m_id = condition.m_id;
}
void UCondition::FillObject(json::Object& obj) const
{
    obj["id"] = m_id;
}

void UCondition::FillMembers(const json::Object& obj)
{
    m_id = obj["id"];
}
