#ifndef UDEVICESUMMARY_H
#define UDEVICESUMMARY_H

#include "Serialization/JsonMacros.h"

BEGIN_DECLARE_JSON_CLASS_ARGS3(UDeviceSummary, int, m_id, int, m_ip, std::string, m_name)

public:
    UDeviceSummary(const UDeviceSummary& deviceSummary);

    void setId(int);

END_DECLARE_JSON_CLASS()

#endif // UDEVICESUMMARY_H
