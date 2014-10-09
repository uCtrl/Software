#ifndef UVOICEINTENT_H
#define UVOICEINTENT_H

namespace EUVoiceIntentType
{
    enum Name
    {
        SetDimmerLightsInLocation,
        SetNinjaEyesColor,
        TurnOnOffAllLights,
        TurnOnOffLightWithId,
        TurnOnOffLightsInLocation,
        TurnOnOffPlugWithId,
        TurnOnOffPlugInLocation
    };
}

class UVoiceIntent
{
public:
    UVoiceIntent();
};

#endif // UVOICEINTENT_H
