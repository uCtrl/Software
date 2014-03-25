#ifndef UDEVICE_H
#define UDEVICE_H

#include "Serialization/JsonMacros.h"
#include "Device/udeviceinfo.h"
#include <QAbstractListModel>
#include <Scenario/uscenario.h>

class UDevice: public QAbstractListModel
{
    Q_OBJECT
public:

    Q_PROPERTY(QList<UScenario*> scenarios READ getScenarios WRITE setScenarios)
    Q_PROPERTY(int id READ getId WRITE setId)
    Q_PROPERTY(QString name READ getName WRITE setName)

    // Device Info
    Q_PROPERTY(float minValue READ getMinValue WRITE setMinValue)
    Q_PROPERTY(float maxValue READ getMaxValue WRITE setMaxValue)
    Q_PROPERTY(int precision READ getPrecision WRITE setPrecision)
    Q_PROPERTY(QString unitLabel READ getUnitLabel WRITE setUnitLabel)
    Q_PROPERTY(int type READ getType WRITE setType)

    UCTRL_JSON(UDevice)

signals:
        void nameChanged(QString);
        void idChanged(int);
        void ipChanged(int);
        void typeChanged(int);

public:

    UDevice(QObject* parent = 0);
    UDevice(const UDevice& device);
    ~UDevice();

    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual int rowCount(const QModelIndex &parent) const;
    QList<UScenario*> getScenarios() const { return m_scenarios; }

    // TODO: this should be better handled
    Q_INVOKABLE QObject* getScenario() const
    {
        const UScenario* scenario = m_scenarios.at(0);// &m_device->getScenarios().at(0);
        return (QObject*) scenario;
    }


    int getId() const { return m_id; }
    QString getName() const {
        return m_name;
    }


    // Device Info
    float getMinValue() const { return m_minValue; }
    float getMaxValue() const { return m_maxValue; }
    int getPrecision() const { return m_precision; }
    QString getUnitLabel() const { return m_unitLabel; }
    int getType() const {
        return m_type;
    }

public slots:
    void setScenarios(QList<UScenario*> arg) { m_scenarios = arg; }
    void setId(int arg) { m_id = arg; }
    void setName(QString arg) { m_name = arg; }

    // Device Info
    void setMinValue(float arg) { m_minValue = arg; }
    void setMaxValue(float arg) { m_maxValue = arg; }
    void setPrecision(int arg) { m_precision = arg; }
    void setUnitLabel(QString arg) { m_unitLabel = arg; }
    void setType(int arg) { m_type = arg; }

private:
    QList<UScenario*> m_scenarios;
    int m_id;
    QString m_name;

    // Device Info
    float m_minValue;
    float m_maxValue;
    int m_precision;
    QString m_unitLabel;
    int m_type;
};

#endif // UDEVICE_H
