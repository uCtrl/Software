#include "udeviceinfobuilder.h"

UDeviceInfoBuilder::UDeviceInfoBuilder()
{
}

UDeviceInfoBuilder::UDeviceInfoBuilder(UDeviceInfo* info)
    : m_info(info)
{
}

UDeviceSummaryBuilder* UDeviceInfoBuilder::createDeviceSummary() {
    return new UDeviceSummaryBuilder(new UDeviceSummary());
}
