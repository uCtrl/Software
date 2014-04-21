#ifndef UDEVICE_H
#define UDEVICE_H

#include "Serialization/jsonserializable.h"
#include "Scenario/uscenario.h"
#include <QAbstractListModel>
#include <QDateTime>

class UScenario;

class UDevice : public QAbstractListModel, public JsonSerializable
{
    Q_OBJECT

    Q_PROPERTY(QList<UScenario*> scenarios READ getScenarios WRITE setScenarios NOTIFY scenariosChanged)
    Q_PROPERTY(int id READ getId WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString name READ getName WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(float minValue READ getMinValue WRITE setMinValue NOTIFY minValueChanged)
    Q_PROPERTY(float maxValue READ getMaxValue WRITE setMaxValue NOTIFY maxValueChanged)
    Q_PROPERTY(int precision READ getPrecision WRITE setPrecision NOTIFY precisionChanged)
    Q_PROPERTY(QString unitLabel READ getUnitLabel WRITE setUnitLabel NOTIFY unitLabelChanged)
    Q_PROPERTY(int type READ getType WRITE setType NOTIFY typeChanged)
    Q_PROPERTY(bool isTriggerValue READ isTriggerValue WRITE setIsTriggerValue NOTIFY isTriggerValueChanged)
    Q_PROPERTY(QString description READ getDescription WRITE setDescription NOTIFY descriptionChanged)
    Q_PROPERTY(QString enabled READ getEnabled WRITE setEnabled NOTIFY enabledChanged)
    Q_PROPERTY(float status READ getStatus WRITE setStatus NOTIFY statusChanged)
    Q_PROPERTY(QDateTime lastUpdate READ getLastUpdate WRITE setLastUpdate NOTIFY updateChanged)

public:
    UDevice() {}
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
    bool isTriggerValue() const { return m_isTriggerValue; }
    QString getDescription() const { return m_description; }
    QString getEnabled() const { return m_enabled; }
    float getStatus() const { return m_status; }
    QDateTime getLastUpdate() const { return m_lastUpdate; }

    QList<UScenario*> getScenarios() const { return m_scenarios; }

    Q_INVOKABLE QObject* createScenario();
    Q_INVOKABLE void addScenario(UScenario* scenario);
    Q_INVOKABLE void deleteScenarioAt(int index);
    Q_INVOKABLE void updateScenarioAt(int index, UScenario* scenario);
    Q_INVOKABLE void saveScenarios();

    // TODO: this should be better handled
    Q_INVOKABLE int getScenarioCount() const { return m_scenarios.count(); }
    Q_INVOKABLE QObject* getScenarioAt(int index) const { return (QObject*) m_scenarios.at(index); }

    void read(const QJsonObject &jsonObj);
    void write(QJsonObject &jsonObj) const;

signals:
    void idChanged(int arg);
    void nameChanged(QString arg);
    void minValueChanged(float arg);
    void maxValueChanged(float arg);
    void precisionChanged(int arg);
    void unitLabelChanged(QString arg);
    void typeChanged(int arg);
    void isTriggerValueChanged(bool arg);
    void descriptionChanged(QString arg);
    void enabledChanged(QString arg);
    void statusChanged(float arg);
    void updateChanged(QDateTime arg);

    void scenariosChanged(QList<UScenario*> arg);

    void save();

public slots:
    void setScenarios(QList<UScenario*> arg) { m_scenarios = arg; }

    void setId(int arg)
    {
        if (m_id != arg) {
            m_id = arg;
            emit idChanged(arg);
        }
    }

    void setEnabled(QString arg)
    {
        if(m_enabled != arg) {
            m_enabled = arg;
            emit enabledChanged(arg);
        }
    }

    void setDescription(QString arg)
    {
        if(m_description != arg) {
            m_description = arg;
            emit descriptionChanged(arg);
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

    void setStatus(float arg)
    {
        if(m_status != arg) {
            m_status = arg;
            emit statusChanged(arg);
        }
    }

    void setLastUpdate(QDateTime arg) {
        if (m_lastUpdate != arg) {
            m_lastUpdate = arg;
            emit updateChanged(arg);
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
    bool m_isTriggerValue;
    QString m_description;
    QString m_enabled;
    float m_status;
    QDateTime m_lastUpdate;
};
Q_DECLARE_METATYPE(QList<UDevice*>)
#endif // UDEVICE_H
