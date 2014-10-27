#include "uvoicecontrolresponse.h"

UVoiceControlResponse::UVoiceControlResponse(QObject *parent)
    : QObject(parent)
{
}

UVoiceControlResponse::UVoiceControlResponse(const QJsonObject& jsonResponse, UNinjaAPI* ninjaAPI, QObject *parent)
    : QObject(parent)
{
    m_msgId = jsonResponse["msg_id"].toString();
    m_text = jsonResponse["_text"].toString();

    m_ninjaAPI = ninjaAPI;

    QJsonArray outcomesArray = jsonResponse["outcomes"].toArray();
    QJsonObject firstOutcome = outcomesArray.first().toObject();

    m_intent = firstOutcome["intent"].toString();
    m_entities = firstOutcome["entities"].toObject();
    m_confidence = firstOutcome["confidence"].toDouble();
}

bool UVoiceControlResponse::getOnOff(const QString& onOffKey)
{
    QString valueString = getFirstJsonValue(onOffKey).toString();

    bool isOn = false;
    if (valueString == QString("on"))
        isOn = true;
    else if (valueString == QString("off"))
        isOn = false;

    return isOn;
}

int UVoiceControlResponse::getInt(const QString& intKey)
{
    int intValue = getFirstJsonValue(intKey).toInt();
    return intValue;
}

QString UVoiceControlResponse::getStringValue(const QString& stringKey)
{
    QString stringValue = getFirstJsonValue(stringKey).toString();
    return stringValue;
}

QJsonValue UVoiceControlResponse::getFirstJsonValue(const QString& key)
{
    QJsonObject entities = getEntities();
    QJsonValue jsonValue = entities[key];
    QJsonArray jsonArray = jsonValue.toArray();
    QJsonObject firstObject = jsonArray.first().toObject();
    QJsonValue firstJsonValue = firstObject["value"];
    return firstJsonValue;
}

QString UVoiceControlResponse::getCommand()
{
    if (getIntent() == QString("turn_onoff_all_lights"))
    {
        bool onOffValue = getOnOff("on_off");
        return QString("Turn {0} all lights").replace("{0}", (onOffValue ? "on" : "off"));
    }
    else if (getIntent() == QString("set_ninja_eyes_color"))
    {
        QString colorString = getStringValue("uctrl_color");
        return QString("Set ninja eyes to {0}").replace("{0}", colorString);
    }
    else if (getIntent() == QString("turn_onoff_plugs_in_location"))
    {
        bool isOn = getOnOff("uctrl_onoff");
        QString locationName = getStringValue("location");
        return QString("Turn {0} all plugs in {1}").replace("{0}", (isOn ? "on" : "off")).replace("{1}", locationName);
    }
    else if (getIntent() == QString("turn_onoff_plug_with_id"))
    {
        bool isOn = getOnOff("uctrl_onoff");
        int plugId = getInt("number");
        return QString("Turn {0} plug with id#{1}").replace("{0}", (isOn ? "on" : "off")).replace("{1}", QString::number(plugId));
    }

    return "Unknown command";
}

bool UVoiceControlResponse::hasValidIntent()
{
    if (getIntent() == QString("turn_onoff_all_lights"))
    {
        return getFirstJsonValue("on_off").toString() != QString("");
    }
    else if (getIntent() == QString("set_ninja_eyes_color"))
    {
        return getStringValue("uctrl_color") != QString("");
    }
    else if (getIntent() == QString("turn_onoff_plugs_in_location"))
    {
        return getFirstJsonValue("uctrl_onoff").toString() != QString("");
    }
    else if (getIntent() == QString("turn_onoff_plug_with_id"))
    {
        return getFirstJsonValue("uctrl_onoff").toString() != QString("") && getFirstJsonValue("number").toInt() != 0;
    }

    return false;
}

void UVoiceControlResponse::sendIntent()
{
    if (getIntent() == QString("turn_onoff_all_lights"))
    {
        bool onOffValue = getOnOff("on_off");
    }
    else if (getIntent() == QString("set_ninja_eyes_color"))
    {
        QString colorString = getStringValue("uctrl_color");

        USetNinjaEyesColorIntent setNinjaEyesColorIntent(m_ninjaAPI, "1014BBBK6089_0_0_1007");
        setNinjaEyesColorIntent.setNinjaEyesColors(colorString);
    }
    else if (getIntent() == QString("turn_onoff_plugs_in_location"))
    {
        bool isOn = getOnOff("uctrl_onoff");
        QString locationName = getStringValue("location");

        UTurnOnOffPlugIntent intent(m_ninjaAPI, "1014BBBK6089_0_0_11", isOn);
        intent.turnOnOffPlugInLocation(locationName);
    }
    else if (getIntent() == QString("turn_onoff_plug_with_id"))
    {
        bool isOn = getOnOff("uctrl_onoff");
        int plugId = getInt("number");

        UTurnOnOffPlugIntent intent(m_ninjaAPI, "1014BBBK6089_0_0_11", isOn);
        intent.turnOnOffPlugWithId(plugId);
    }
}
