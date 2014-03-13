#include "uplatformbuilder.h"

UPlatformBuilder::UPlatformBuilder(UPlatformBuilderObserver* platformBuilderObserver)
    : m_platformBuilderObserver(platformBuilderObserver)
{

}

UPlatformBuilder::UPlatformBuilder(UPlatformBuilderObserver *platformBuilderObserver, const UPlatform &platform)
    : m_platformBuilderObserver(platformBuilderObserver)
    , m_platform(platform)
{
}

UPlatformBuilder::~UPlatformBuilder()
{
}

void UPlatformBuilder::updatedDeviceInfo(UDeviceInfo &deviceInfo)
{

}


void UPlatformBuilder::updateDeviceScenario(int scenarioId, UScenario &deviceScenario)
{

}

void UPlatformBuilder::restoreDeviceDefault(int deviceId)
{

}

void UPlatformBuilder::getAllDevices()
{    

}
