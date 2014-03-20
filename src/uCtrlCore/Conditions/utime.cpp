#include "utime.h"

UTime::UTime()
{
}

void UTime::FillObject(json::Object& obj) const
{
    obj["m_hours"] = getHours();
    obj["m_minutes"] = getMinutes();
    obj["m_seconds"] = getSeconds();
}

void UTime::FillMembers(const json::Object& obj)
{
    setHours(obj["m_hours"]);
    setMinutes(obj["m_minutes"]);
    setSeconds(obj["m_seconds"]);
}
