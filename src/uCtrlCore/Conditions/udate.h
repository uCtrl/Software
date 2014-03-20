#ifndef UDATE_H
#define UDATE_H

#include "Serialization/JsonMacros.h"

BEGIN_DECLARE_JSON_CLASS_ARGS3(UDate, int, Day, int, Month, int, Year)

UDate(const UDate& date);

END_DECLARE_JSON_CLASS()

#endif // UDATE_H
