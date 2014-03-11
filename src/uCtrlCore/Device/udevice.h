#ifndef UDEVICE_H
#define UDEVICE_H

#include "Serialization/JsonMacros.h"
#include "Scenario/uscenario.h"
#include <string>
#include <vector>


BEGIN_DECLARE_JSON_CLASS_ARGS3(UDevice, int, m_id, std::string, m_name, std::vector<UScenario>, m_deviceScenarios)

public:
    UDevice(const UDevice& device);

    // accessors
    int id() const { return m_id; }
    const std::string& name() const { return m_name; }
    const std::vector<UScenario>& scenarios() const { return m_deviceScenarios; }

END_DECLARE_JSON_CLASS()

#endif // UDEVICE_H
