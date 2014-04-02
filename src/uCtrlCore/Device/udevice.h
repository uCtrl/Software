#ifndef UDEVICE_H
#define UDEVICE_H

#include "Serialization/jsonserializable.h"
#include "Scenario/uscenario.h"
#include "Models/UComboBoxItemList.h"
#include <QAbstractListModel>

class UDevice : public QAbstractListModel, public JsonSerializable
{
    Q_OBJECT

    Q_PROPERTY(QList<UScenario*> scenarios READ getScenarios WRITE setScenarios)
    Q_PROPERTY(int id READ getId WRITE setId)
    Q_PROPERTY(QString name READ getName WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(float minValue READ getMinValue WRITE setMinValue)
    Q_PROPERTY(float maxValue READ getMaxValue WRITE setMaxValue)
    Q_PROPERTY(int precision READ getPrecision WRITE setPrecision)
    Q_PROPERTY(QString unitLabel READ getUnitLabel WRITE setUnitLabel)
    Q_PROPERTY(int type READ getType WRITE setType NOTIFY typeChanged)

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

    QList<UScenario*> getScenarios() const { return m_scenarios; }

    // TODO: this should be better handled
    Q_INVOKABLE QObject* getScenario() const { return (QObject*) m_scenarios.at(0); }
    Q_INVOKABLE QObject* getComboBoxItemList();

    void read(const QJsonObject &jsonObj);
    void write(QJsonObject &jsonObj) const;

signals:
    void nameChanged(QString);
    void idChanged(int);
    void ipChanged(int);
    void typeChanged(int);

public slots:
    void setId(int arg) { m_id = arg; }
    void setName(QString arg) { m_name = arg; }
    void setScenarios(QList<UScenario*> arg) { m_scenarios = arg; }
    void setMinValue(float arg) { m_minValue = arg; }
    void setMaxValue(float arg) { m_maxValue = arg; }
    void setPrecision(int arg) { m_precision = arg; }
    void setUnitLabel(QString arg) { m_unitLabel = arg; }
    void setType(int arg) { m_type = arg; }

private:
    int m_id;
    QString m_name;
    QList<UScenario*> m_scenarios;
    float m_minValue;
    float m_maxValue;
    int m_precision;
    QString m_unitLabel;
    int m_type;
};
#endif // UDEVICE_H
