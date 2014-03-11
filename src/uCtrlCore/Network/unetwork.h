#ifndef UNETWORK_H
#define UNETWORK_H

#include "../Device/udevicesummary.h"
#include "../Device/udeviceinfo.h"
#include "../Scenario/uscenario.h"

class UNetwork
{
public:
    UNetwork();
    ~UNetwork();

    void getDeviceInfo(const UDeviceSummary& deviceSummary);
    void updateDeviceInfo(UDeviceInfo& deviceInfo);
    void updateDeviceScenario(int scenarioId, UScenario& deviceScenario);
    void getAllDevicesSummaries();
    void restoreDeviceDefault(int deviceId);

};

#endif // UNETWORK_H
