#ifndef UDEVICE_H
#define UDEVICE_H

#include "../Serialization/JsonMacros.h"
#include "../Scenario/uscenario.h"
#include <string>
#include <vector>


BEGIN_DECLARE_JSON_CLASS_ARGS3(UDevice, int, m_id, std::string, m_name, std::vector<UScenario>, m_deviceScenarios)

public:
    UDevice(const UDevice& device);

END_DECLARE_JSON_CLASS()

#endif // UDEVICE_H
