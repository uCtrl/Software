#ifndef UDEVICEBUILDER_H
#define UDEVICEBUILDER_H

#include "udevice.h"
#include "../Scenario/uscenariobuilder.h"
#include "../Scenario/uscenariobuilderobserver.h"

class UDeviceBuilder : public UScenarioBuilderObserver
{
public:
    UDeviceBuilder();
    UDeviceBuilder(UDevice* device);

    const UDevice* getDevice() { return m_device; }

    UScenarioBuilder* createScenario();
    UScenarioBuilder* editScenario(int scenarioId);
    void deleteScenario(int scenarioId);

    // Scenario Builder Observer
    void onScenarioUpdated(const UScenario& updatedScenario);

private:
    UDevice* m_device;
};

#endif // UDEVICEBUILDER_H
