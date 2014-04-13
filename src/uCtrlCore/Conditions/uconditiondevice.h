#ifndef UCONDITIONDEVICE_H
#define UCONDITIONDEVICE_H

#include "ucondition.h"

class UConditionDevice : public UCondition
{
    Q_OBJECT

    Q_PROPERTY(UEDeviceType deviceType READ getDeviceType WRITE setDeviceType NOTIFY deviceTypeChanged)

    Q_ENUMS(UEDeviceType)

public:
    enum class UEDeviceType : int {
        Temperature = 0,
        MotionSensor = 1,
        LightSensor = 2,
        Light = 3,
        ElectricPlug = 4
    };

    UConditionDevice() {}
    UConditionDevice(QObject* parent) : UCondition(parent, UEConditionType::Device) {}
    UConditionDevice(QObject *parent, UConditionDevice* conditionDevice);

    UEDeviceType getDeviceType() const { return m_deviceType; }

    virtual void read(const QJsonObject &jsonObj);
    virtual void write(QJsonObject &jsonObj) const;
public slots:
    void setDeviceType(UEDeviceType arg)
    {
        if (m_deviceType != arg) {
            m_deviceType = arg;
            emit deviceTypeChanged(arg);
        }
    }
signals:
    void deviceTypeChanged(UEDeviceType arg);

private:
    UEDeviceType m_deviceType;
};

#endif // UCONDITIONDEVICE_H
