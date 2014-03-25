#ifndef UDEVICEINFO_H
#define UDEVICEINFO_H

#include "Serialization/JsonMacros.h"
#include <QObject>

class UDeviceInfo: QObject
{
    UCTRL_JSON(UDeviceInfo)
    Q_PROPERTY(float minValue READ getMinValue WRITE setMinValue)
    Q_PROPERTY(float maxValue READ getMaxValue WRITE setMaxValue)
    Q_PROPERTY(int precision READ getPrecision WRITE setPrecision)
    Q_PROPERTY(QString unitLabel READ getUnitLabel WRITE setUnitLabel)
    Q_PROPERTY(int type READ getType WRITE setType)

public:
    UDeviceInfo(QObject* parent = 0);
    UDeviceInfo(const UDeviceInfo& deviceInfo);

    float getMinValue() const { return m_minValue; }
    float getMaxValue() const { return m_maxValue; }
    int getPrecision() const { return m_precision; }
    QString getUnitLabel() const { return m_unitLabel; }
    int getType() const { return m_type; }

public slots:
    void setMinValue(float arg) { m_minValue = arg; }
    void setMaxValue(float arg) { m_maxValue = arg; }
    void setPrecision(int arg) { m_precision = arg; }
    void setUnitLabel(QString arg) { m_unitLabel = arg; }
    void setType(int arg) { m_type = arg; }

    private:
    float m_minValue;
    float m_maxValue;
    int m_precision;
    QString m_unitLabel;
    int m_type;
};

#endif // UDEVICEINFO_H
