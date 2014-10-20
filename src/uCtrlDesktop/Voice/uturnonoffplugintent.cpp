#include "uturnonoffplugintent.h"

UTurnOnOffPlugIntent::UTurnOnOffPlugIntent(UNinjaAPI* ninjaAPI, const QString& deviceId, bool turnOn)
{
    m_ninjaAPI = ninjaAPI;
    m_deviceId = deviceId;
    m_isTurnOn = turnOn;
}

void UTurnOnOffPlugIntent::turnOnOffPlugWithId(long id)
{
    QString data(SocketTypeRFCode);

    if (m_isTurnOn)
        data = data.append(SocketOnRFCode);
    else
        data = data.append(SocketOffRFCode);

    if (id == 1)
        data = data.append(Socket1RFCode);
    else if (id == 2)
        data = data.append(Socket2RFCode);
    else if (id == 3)
        data = data.append(Socket3RFCode);
    else
        return;

    m_ninjaAPI->sendData(m_deviceId, data);
}



void UTurnOnOffPlugIntent::turnOnOffPlugInLocation(QString location)
{
    if (location == QString("living room"))
    {
        turnOnOffPlugWithId(1);
    }
    else if (location == QString("kitchen"))
    {
        turnOnOffPlugWithId(2);
        turnOnOffPlugWithId(3);
    }
}
