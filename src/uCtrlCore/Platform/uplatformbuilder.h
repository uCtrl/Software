#ifndef UPLATFORMBUILDER_H
#define UPLATFORMBUILDER_H

#include "uplatform.h"
#include "uplatformbuilderobserver.h"
#include "Device/udevice.h"
#include "Device/udevicebuilder.h"
#include "Device/udevicebuilderobserver.h"
#include "Device/udeviceinfo.h"
#include "Device/udevicesummary.h"
#include "Utility/uniqueidgenerator.h"
#include "list"

class UPlatformBuilder
{
public:
    UPlatformBuilder(UPlatformBuilderObserver* platformBuilderObserver);
    UPlatformBuilder(UPlatformBuilderObserver *platformBuilderObserver, const UPlatform& platform);
    ~UPlatformBuilder();

    const UPlatform*  getDeviceInfo() const {return &m_platform;}
    void updatedDeviceInfo(UDeviceInfo& deviceInfo);
    void updateDeviceScenario(int scenarioId, UScenario& deviceScenario);
    void getAllDevices();
    void restoreDeviceDefault(int deviceId);

private:
    UPlatformBuilderObserver* m_platformBuilderObserver;
    UPlatform m_platform;

};

#endif // UPLATFORMBUILDER_H
