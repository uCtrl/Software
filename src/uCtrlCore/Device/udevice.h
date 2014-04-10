#ifndef UDEVICE_H
#define UDEVICE_H

#include "Serialization/jsonserializable.h"
#include "Scenario/uscenario.h"
#include "Device/udeviceinfo.h"
#include <QAbstractListModel>

class UDevice : public QAbstractListModel, public JsonSerializable
{
    Q_OBJECT

    Q_PROPERTY(QList<UScenario*> scenarios READ getScenarios WRITE setScenarios)
    Q_PROPERTY(int id READ getId WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString name READ getName WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(float minValue READ getMinValue WRITE setMinValue NOTIFY minValueChanged)
    Q_PROPERTY(float maxValue READ getMaxValue WRITE setMaxValue NOTIFY maxValueChanged)
    Q_PROPERTY(int precision READ getPrecision WRITE setPrecision NOTIFY precisionChanged)
    Q_PROPERTY(QString unitLabel READ getUnitLabel WRITE setUnitLabel NOTIFY unitLabelChanged)
    Q_PROPERTY(int type READ getType WRITE setType NOTIFY typeChanged)
    Q_PROPERTY(QString mac READ getMac WRITE setMac)
    Q_PROPERTY(QString firmwareVersion READ getFirmwareVersion WRITE setFirmwareVersion)
    Q_PROPERTY(bool isTriggerValue READ isTriggerValue WRITE setIsTriggerValue NOTIFY isTriggerValueChanged)

public:
    UDevice(QObject* parent);
    UDevice(const UDevice& device);
    ~UDevice();

    virtual QVariant data(const QModelIndex &index, int role) const { return QVariant();}
    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const { return m_scenarios.count();}

    int getId() const { return m_id; }
    QString getName() const { return m_name; }
    float getMinValue() const { return m_minValue; }
    float getMaxValue() const { return m_maxValue; }
    int getPrecision() const { return m_precision; }
    QString getUnitLabel() const { return m_unitLabel; }
    int getType() const { return m_type; }
    QString getMac() const { return m_mac; }
    QString getFirmwareVersion() const { return m_firmwareVersion; }
    bool isTriggerValue() const { return m_isTriggerValue; }

    QList<UScenario*> getScenarios() const { return m_scenarios; }

    // TODO: this should be better handled
    Q_INVOKABLE int getScenarioCount() const { return m_scenarios.count(); }
    Q_INVOKABLE QObject* getScenarioAt(int index) const { return (QObject*) m_scenarios.at(index); }

    void read(const QJsonObject &jsonObj);
    void write(QJsonObject &jsonObj) const;

    Q_INVOKABLE QObject* getDeviceInfo() {
        UDeviceInfo* deviceInfo = new UDeviceInfo();

        deviceInfo->setId(m_id);
        deviceInfo->setName(m_name);
        deviceInfo->setMinValue(m_minValue);
        deviceInfo->setMaxValue(m_maxValue);
        deviceInfo->setPrecision(m_precision);
        deviceInfo->setUnitLabel(m_unitLabel);
        deviceInfo->setType(m_type);
        deviceInfo->setMac(m_mac);
        deviceInfo->setFirmwareVersion(m_firmwareVersion);

        return deviceInfo;
    }

signals:
    void idChanged(int arg);
    void nameChanged(QString arg);
    void minValueChanged(float arg);
    void maxValueChanged(float arg);
    void precisionChanged(int arg);
    void unitLabelChanged(QString arg);
    void typeChanged(int arg);
    void isTriggerValueChanged(bool arg);

public slots:
    void setScenarios(QList<UScenario*> arg) { m_scenarios = arg; }

    void setId(int arg)
    {
        if (m_id != arg) {
            m_id = arg;
            emit idChanged(arg);
        }
    }

    void setName(QString arg)
    {
        if (m_name != arg) {
            m_name = arg;
            emit nameChanged(arg);
        }
    }

    void setMinValue(float arg)
    {
        if (m_minValue != arg) {
            m_minValue = arg;
            emit minValueChanged(arg);
        }
    }

    void setMaxValue(float arg)
    {
        if (m_maxValue != arg) {
            m_maxValue = arg;
            emit maxValueChanged(arg);
        }
    }

    void setPrecision(int arg)
    {
        if (m_precision != arg) {
            m_precision = arg;
            emit precisionChanged(arg);
        }
    }

    void setUnitLabel(QString arg)
    {
        if (m_unitLabel != arg) {
            m_unitLabel = arg;
            emit unitLabelChanged(arg);
        }
    }

    void setType(int arg)
    {
        if (m_type != arg) {
            m_type = arg;
            emit typeChanged(arg);
        }
    }

    void setIsTriggerValue(bool arg)
    {
        if (m_isTriggerValue != arg) {
            m_isTriggerValue = arg;
            emit isTriggerValueChanged(arg);
        }
    }

    void setMac(QString arg)
    {
        if (m_mac != arg) {
            m_mac = arg;
        }
    }

    void setFirmwareVersion(QString arg)
    {
        if (m_firmwareVersion != arg) {
            m_firmwareVersion = arg;
        }
    }

private:
    int m_id;
    QString m_name;
    QList<UScenario*> m_scenarios;
    float m_minValue;
    float m_maxValue;
    int m_precision;
    QString m_unitLabel;
    int m_type;
    QString m_mac;
    QString m_firmwareVersion;
    bool m_isTriggerValue;
};
Q_DECLARE_METATYPE(QList<UDevice*>)
#endif // UDEVICE_H
