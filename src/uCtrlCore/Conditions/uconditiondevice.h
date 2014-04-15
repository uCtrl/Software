#ifndef UCONDITIONDEVICE_H
#define UCONDITIONDEVICE_H

#include "ucondition.h"

class UConditionDevice : public UCondition
{
    Q_OBJECT

    Q_PROPERTY(UEDeviceType deviceType READ getDeviceType WRITE setDeviceType NOTIFY deviceTypeChanged)
    Q_PROPERTY(int deviceId READ getDeviceId WRITE setDeviceId NOTIFY deviceIdChanged)
    Q_PROPERTY(float beginValue READ getBeginValue WRITE setBeginValue NOTIFY beginValueChanged)
    Q_PROPERTY(float endValue READ getEndValue WRITE setEndValue NOTIFY endValueChanged)

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
    UConditionDevice(QObject* parent) : UCondition(parent, UEConditionType::Device), m_deviceId(-1), m_beginValue(0), m_endValue(0) {}
    UConditionDevice(QObject *parent, UConditionDevice* conditionDevice);

    UEDeviceType getDeviceType() const { return m_deviceType; }
    int getDeviceId() const { return m_deviceId; }
    float getBeginValue() const { return m_beginValue; }
    float getEndValue() const { return m_endValue; }

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

    void setDeviceId(int arg)
    {
        if (m_deviceId != arg) {
            m_deviceId = arg;
            emit deviceIdChanged(arg);
        }
    }

    void setBeginValue(float arg)
    {
        if (m_beginValue != arg) {
            m_beginValue = arg;
            emit beginValueChanged(arg);
        }
    }

    void setEndValue(float arg)
    {
        if (m_endValue != arg) {
            m_endValue = arg;
            emit endValueChanged(arg);
        }
    }

signals:
    void deviceTypeChanged(UEDeviceType arg);
    void deviceIdChanged(int arg);
    void beginValueChanged(float arg);
    void endValueChanged(float arg);

private:
    UEDeviceType m_deviceType;
    int m_deviceId;
    float m_beginValue;
    float m_endValue;
};

#endif // UCONDITIONDEVICE_H
