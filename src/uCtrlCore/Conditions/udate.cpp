#include "udate.h"

UDate::UDate()
{
}

UDate::UDate(const UDate& date)
{
    setDay(date.getDay());
    setMonth(date.getMonth());
    setYear(date.getYear());
}

void UDate::FillObject(json::Object& obj) const
{
    obj["m_day"] = getDay();
    obj["m_month"] = getMonth();
    obj["m_year"] = getYear();
}

void UDate::FillMembers(const json::Object& obj)
{
    setDay(obj["m_day"]);
    setMonth(obj["m_month"]);
    setYear(obj["m_year"]);
}

