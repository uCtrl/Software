#include "udate.h"

#ifndef UDATE_H
#define UDATE_H

#include "Serialization/JsonMacros.h"

DECLARE_JSON_CLASS_ARGS3(UDate, int, m_day, int, m_month, int, m_year)

#endif // UDATE_H
json::Object UDate::ToObject()
{
	json::Object obj;
	FillObject(obj);
	return obj;
}

void UDate::FillObject(json::Object& obj)
{
	obj["m_day"] = m_day;
	obj["m_month"] = m_month;
	obj["m_year"] = m_year;
}

std::string UDate::Serialize()
{
	json::Object obj = ToObject();
	return json::Serialize(obj);
}

void UDate::FillMembers(const json::Object& obj)
{
	m_day = obj["m_day"];
	m_month = obj["m_month"];
	m_year = obj["m_year"];
}

UDate UDate::Deserialize(const json::Object& obj)
{
	UDate o;
	o.FillMembers(obj);
	return o;
}

