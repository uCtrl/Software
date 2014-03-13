#include "UNetwork.h"

UNetwork::UNetwork()
{
}

UNetwork::~UNetwork()
{

}
/*
UNetwork::getDeviceInfo(const UDeviceSummary& deviceSummary)
{
    //reçoit un deviceSummary et retourne un deviceInfo
}

UNetwork::getAllDevicesSummaries()
{

}
*/
void UNetwork::updateDeviceInfo(UDeviceInfo& deviceInfo)
{
    UDeviceInfo* tmpDeviceInfo = new UDeviceInfo(deviceInfo);

    tmpDeviceInfo->minValue = 0.0;
    tmpDeviceInfo->maxValue = 10.0;
    tmpDeviceInfo->precision = 1;
    tmpDeviceInfo->unitLabel = "Temperature";
    tmpDeviceInfo->type = 0x1011;


}
/*
UNetwork::updateDeviceScenario(int scenarioId, UScenario& scenario)
{

}
*/
