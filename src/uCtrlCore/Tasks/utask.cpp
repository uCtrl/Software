#include "utask.h"
#include "Utility/uniqueidgenerator.h"
#include <sstream>

UTask::UTask(QObject* parent)
    : QAbstractListModel(parent)
{
    setId(UniqueIdGenerator::GenerateUniqueId());
}

UTask::UTask(const UTask* task)
{
    setId(task->getId());
    setStatus(task->getStatus());
    setConditions(task->getConditions());
}

UTask::~UTask()
{
    m_conditions.clear();
}

void UTask::addCondition( UCondition *cond)
{
    m_conditions.push_back(cond);
}

void UTask::fillObject(json::Object& obj) const
{
    obj["id"] = getId();
    obj["status"] = getStatus().toStdString();

    // WARNING : Custom code
    obj["conditions_size"] = (int) getConditions().size();
    for (int i = 0; i < getConditions().size(); i++)
    {
        std::ostringstream oss;
        oss << "conditions[" << i << "]";

        std::string key = oss.str();
        obj[key] = getConditions()[i]->ToObject();
    }

}

void UTask::fillMembers(const json::Object& obj)
{
    setId(obj["id"]);
    setStatus(QString::fromStdString(obj["status"].ToString()));

    // WARNING : Custom code
    int m_conditions_size = obj["conditions_size"];
    for (int i = 0 ; i < m_conditions_size; i++)
    {
        std::ostringstream oss;
        oss << "conditions[" << i << "]";

        std::string key = oss.str();
        UCondition* condition = new UCondition();
        condition->deserialize(obj[key]);
        m_conditions.push_back(condition);
    }
}
