#include "utime.h"

UTime::UTime()
{
}

void UTime::FillObject(json::Object& obj) const
{
	obj["m_hours"] = m_hours;
	obj["m_minutes"] = m_minutes;
	obj["m_seconds"] = m_seconds;
}

void UTime::FillMembers(const json::Object& obj)
{
	m_hours = obj["m_hours"];
	m_minutes = obj["m_minutes"];
	m_seconds = obj["m_seconds"];
}
