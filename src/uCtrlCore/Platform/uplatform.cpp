#include "uplatform.h"

UPlatform::UPlatform()
{
}

UPlatform::~UPlatform()
{

}

void UPlatform::getDeviceInfo(int deviceId)
{

}

void UPlatform::updatedDeviceInfo(UDeviceInfo &deviceInfo)
{

}
/*
void UPlatform::updateDeviceScenario(int deviceId, UScenario &deviceScenario)
{
    for (int i = 0; i < m_device.size(); ++i)
        {
            if (m_device[i].id() == scenarioId)
            {
                std::vector<UScenario>::iterator iter = m_device.begin() + i;

                m_device.erase(iter);
                m_device.insert(iter, deviceScenario);
                return;
            }
        }

        m_device.push_back(deviceScenario);
}

void UPlatform::restoreDeviceDefault(int deviceId)
{
    if(deviceId == 1234){
        m_device.m_name = "Light";
    }
    else if (deviceId == 2345){
        m_device.m_name == "Thermomether"
    }
    else{
        m_device.m_name == "Motion Sensor"
    }

}
*/
void UPlatform::getAllDevices(GetAllDevicesCallback* callback)
{
    if (devicesVector.size() == 0)
    {
        //Create Mock Device
        UDevice light;
        light.m_id = 1234;
        light.m_name = "Light";

        UDevice thermomether;
        thermomether.m_id = 2345;
        thermomether.m_name = "Thermomether";

        UDevice motionsensor;
        motionsensor.m_id = 3456;
        motionsensor.m_name = "Motion Sensor";

        devicesVector.push_back(light);
        devicesVector.push_back(thermomether);
        devicesVector.push_back(motionsensor);
    }

    callback->Invoke(devicesVector);
}
