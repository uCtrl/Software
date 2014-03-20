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

void UDate::FillObject(json::Object& obj) const
{
	obj["m_day"] = m_day;
	obj["m_month"] = m_month;
	obj["m_year"] = m_year;
}

void UDate::FillMembers(const json::Object& obj)
{
	m_day = obj["m_day"];
	m_month = obj["m_month"];
	m_year = obj["m_year"];
}

