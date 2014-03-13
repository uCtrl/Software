#ifndef UDEVICEBUILDER_H
#define UDEVICEBUILDER_H

#include "udevice.h"
#include "udeviceinfo.h"
#include "udeviceinfobuilder.h"
#include "Scenario/uscenariobuilder.h"
#include "Scenario/uscenariobuilderobserver.h"

class UDeviceBuilder : public UScenarioBuilderObserver
{
public:
    UDeviceBuilder();
    UDeviceBuilder(const UDevice& device);

    void setName(const std::string& name);
    void setDeviceInfo(UDeviceInfo* info) { m_device.m_infos = info; }
    const UDevice* getDevice() const { return &m_device; }

    UDeviceInfoBuilder* createDeviceInfo();

    UScenarioBuilder* createScenario();
    UScenarioBuilder* editScenario(int scenarioId);
    void deleteScenario(int scenarioId);

    // Scenario Builder Observer
    void onScenarioUpdated(const UScenario& updatedScenario);

private:
    UDevice m_device;
};

#endif // UDEVICEBUILDER_H
