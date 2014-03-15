#include "utime.h"

#ifndef UTIME_H
#define UTIME_H

#include "Serialization/JsonMacros.h"

DECLARE_JSON_CLASS_ARGS3(UTime, int, m_hours, int, m_minutes, int, m_seconds)

#endif // UTIME_H
json::Object UTime::ToObject()
{
	json::Object obj;
	FillObject(obj);
	return obj;
}

void UTime::FillObject(json::Object& obj)
{
	obj["m_hours"] = m_hours;
	obj["m_minutes"] = m_minutes;
	obj["m_seconds"] = m_seconds;
}

std::string UTime::Serialize()
{
	json::Object obj = ToObject();
	return json::Serialize(obj);
}

void UTime::FillMembers(const json::Object& obj)
{
	m_hours = obj["m_hours"];
	m_minutes = obj["m_minutes"];
	m_seconds = obj["m_seconds"];
}

UTime UTime::Deserialize(const json::Object& obj)
{
	UTime o;
	o.FillMembers(obj);
	return o;
}

