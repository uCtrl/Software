#ifndef UDEVICE_H
#define UDEVICE_H

#include "Models/nestedlistitem.h"
#include "Models/nestedlistmodel.h"
#include "Scenario/uscenariosmodel.h"
#include "History/uhistorylogmodel.h"
#include "Statistics/ustatisticsmodel.h"

class UDevice : public NestedListItem
{
    Q_OBJECT

    enum DeviceRoles
    {
        idRole = Qt::UserRole + 1,
        nameRole,
        typeRole,
        descriptionRole,
        maxValueRole,
        minValueRole,
        valueRole,
        precisionRole,
        statusRole,
        unitLabelRole,
        enabledRole,
        lastUpdatedRole
    };

public:
    Q_ENUMS(UEStatus)
    Q_ENUMS(UEType)

    enum class UEStatus: int {
        Ok = 0,
        Disconnected = 1,
        Error
    };

    enum class UEType: int {
        PushButton = 5,
        LightSensor = 6,
        PIRMotionSensor = 7,
        RF4333 = 11,
        Humidity = 30,
        Temperature = 31,
        Switch = 206,
        ProximitySensor = 219,
        Light = 233,
        StatusLight = 999,
        OnBoardRGBLed = 1000,
        NinjasEyes = 1007,
        BelkinWeMoSocket = 1009
    };

    explicit UDevice(QObject *parent = 0);
    ~UDevice();

    // NestedListItem
    QVariant data(int role) const;
    bool setData(const QVariant &value, int role);
    QHash<int, QByteArray> roleNames() const;
    ListModel* nestedModel() const;

    // JsonSerializable
    void write(QJsonObject &jsonObj) const;
    void read(const QJsonObject &jsonObj);

    // Properties
    QString name() const;
    void name(const QString& name);
    UEType type() const;
    void type(UEType type);
    QString description() const;
    void description(const QString& description);
    QString maxValue() const;
    void maxValue(const QString& maxValue);
    QString minValue() const;
    void minValue(const QString& minValue);
    QString value() const;
    void value(const QString& value);
    int precision() const;
    void precision(int precision);
    UEStatus status() const;
    void status(UEStatus status);
    QString unitLabel() const;
    void unitLabel(const QString& unitLabel);

    ListModel* history() const;
    ListModel* statistics() const;

private:
    QString m_name;
    UEType m_type;
    QString m_description;
    QString m_maxValue;
    QString m_minValue;
    QString m_value;
    int m_precision;
    UEStatus m_status;
    QString m_unitLabel;
    NestedListModel* m_scenarios;
    ListModel* m_statistics;
};

#endif // UDEVICE_H
