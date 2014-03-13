#ifndef UPLATFORM_H
#define UPLATFORM_H

#include "Device/udevice.h"
#include "Device/udevicebuilder.h"
#include "Device/udevicebuilderobserver.h"
#include "Device/udeviceinfo.h"
#include "Device/udevicesummary.h"
#include "Utility/uniqueidgenerator.h"

class GetAllDevicesCallback
{
public:
    virtual void Invoke(const std::vector<UDevice>& devicesVector);
};

class UPlatform
{
public:
    UPlatform();
    ~UPlatform();

    void getDeviceInfo(int deviceId);
    void updatedDeviceInfo(UDeviceInfo& deviceInfo);
    void updateDeviceScenario(int deviceId, UScenario& deviceScenario);
    void getAllDevices(GetAllDevicesCallback* callback);
    void restoreDeviceDefault(int deviceId);

private:
    UDevice m_device;
    std::vector<UDevice> devicesVector;
};

#endif // UPLATFORM_H
