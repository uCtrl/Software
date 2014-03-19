#ifndef UTIME_H
#define UTIME_H

#include "Serialization/JsonMacros.h"

DECLARE_JSON_CLASS_ARGS3(UTime, int, m_hours, int, m_minutes, int, m_seconds)

#endif // UTIME_H
