#ifndef UDEVICESUMMARY_H
#define UDEVICESUMMARY_H

#include "Serialization/JsonMacros.h"

BEGIN_DECLARE_JSON_CLASS_ARGS3(UDeviceSummary, int, id, int, ip, std::string, name)

public:
    UDeviceSummary(const UDeviceSummary& deviceSummary);

END_DECLARE_JSON_CLASS()

#endif // UDEVICESUMMARY_H
