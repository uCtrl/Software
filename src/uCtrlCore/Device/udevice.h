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
        maxStatRole,
        minStatRole,
        meanStatRole,
        countStatRole,
        precisionRole,
        statusRole,
        unitLabelRole,
        enabledRole,
        lastUpdatedRole,
        deviceModelRole
    };

public:
    Q_ENUMS(UEStatus)
    Q_ENUMS(UEType)

    enum class UEStatus: int {
        Ok = 0,
        Disconnected = 1,
        Error
    };

    // TODO: Missing types?
    enum class UEType: int {
        None = 0,
        PowerSocketSwitch = 1,
        PushButton = 5,
        MotionSensor = 7,
        Humidity = 30,
        Temperature = 31,
        NinjasEyes = 1007,
        LimitlessLEDWhite = 1012,
        DoorSensor = 9990,
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
    QString minStat() const;
    void minStat(const QString& minStat);
    QString maxStat() const;
    void maxStat(const QString& maxStat);
    QString meanStat() const;
    void meanStat(const QString& meanStat);
    QString countStat() const;
    void countStat(const QString& countStat);
    int precision() const;
    void precision(int precision);
    UEStatus status() const;
    void status(UEStatus status);
    QString unitLabel() const;
    void unitLabel(const QString& unitLabel);
    QString deviceModel() const;
    void deviceModel(const QString& deviceModel);

    ListModel* history() const;
    ListModel* statistics() const;

private:
    QString m_name;
    UEType m_type;
    QString m_description;
    QString m_maxValue;
    QString m_minValue;
    QString m_value;
    QString m_maxStat;
    QString m_minStat;
    QString m_meanStat;
    QString m_countStat;
    int m_precision;
    UEStatus m_status;
    QString m_unitLabel;
    QString m_deviceModel;
    NestedListModel* m_scenarios;
    ListModel* m_statistics;
    ListModel* m_history;
};

#endif // UDEVICE_H
