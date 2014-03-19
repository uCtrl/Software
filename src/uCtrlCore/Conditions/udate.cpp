#include "udate.h"

UDate::UDate()
{
}

UDate::UDate(const UDate& date)
{
    this->m_day = date.m_day;
    this->m_month = date.m_month;
    this->m_year = date.m_year;
}

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

