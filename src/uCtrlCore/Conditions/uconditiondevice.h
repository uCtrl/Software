#ifndef UCONDITIONDEVICE_H
#define UCONDITIONDEVICE_H

#include "ucondition.h"

class UConditionDevice : public UCondition
{
    Q_OBJECT

    Q_PROPERTY(UEDeviceType deviceType READ getDeviceType WRITE setDeviceType NOTIFY deviceTypeChanged)
    Q_PROPERTY(int deviceId READ getDeviceId WRITE setDeviceId NOTIFY deviceIdChanged)

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
    UConditionDevice(QObject* parent) : UCondition(parent, UEConditionType::Device), m_deviceId(-1) {}
    UConditionDevice(QObject *parent, UConditionDevice* conditionDevice);

    UEDeviceType getDeviceType() const { return m_deviceType; }

    virtual void read(const QJsonObject &jsonObj);
    virtual void write(QJsonObject &jsonObj) const;
    int getDeviceId() const
    {
        return m_deviceId;
    }

public slots:
    void setDeviceType(UEDeviceType arg)
    {
        if (m_deviceType != arg) {
            m_deviceType = arg;
            emit deviceTypeChanged(arg);
        }
    }
    void setDeviceId(int arg)
    {
        if (m_deviceId != arg) {
            m_deviceId = arg;
            emit deviceIdChanged(arg);
        }
    }

signals:
    void deviceTypeChanged(UEDeviceType arg);
    void deviceIdChanged(int arg);

private:
    UEDeviceType m_deviceType;
    int m_deviceId;
};

#endif // UCONDITIONDEVICE_H
