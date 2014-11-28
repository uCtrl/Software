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
        DoorSensor = 9990
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
    void read(const QJsonObject &jsonObgitj);
    void readScenarios(const QJsonObject &jsonObj);

    // Properties
    Q_INVOKABLE QString name() const;
    Q_INVOKABLE void name(const QString& name);
    Q_INVOKABLE UEType type() const;
    Q_INVOKABLE void type(UEType type);
    Q_INVOKABLE QString description() const;
    Q_INVOKABLE void description(const QString& description);
    Q_INVOKABLE QString maxValue() const;
    Q_INVOKABLE void maxValue(const QString& maxValue);
    Q_INVOKABLE QString minValue() const;
    Q_INVOKABLE void minValue(const QString& minValue);
    Q_INVOKABLE QString value() const;
    Q_INVOKABLE void value(const QString& value);
    Q_INVOKABLE QString minStat() const;
    Q_INVOKABLE void minStat(const QString& minStat);
    Q_INVOKABLE QString maxStat() const;
    Q_INVOKABLE void maxStat(const QString& maxStat);
    Q_INVOKABLE QString meanStat() const;
    Q_INVOKABLE void meanStat(const QString& meanStat);
    Q_INVOKABLE QString countStat() const;
    Q_INVOKABLE void countStat(const QString& countStat);
    Q_INVOKABLE int precision() const;
    Q_INVOKABLE void precision(int precision);
    Q_INVOKABLE UEStatus status() const;
    Q_INVOKABLE void status(UEStatus status);
    Q_INVOKABLE QString unitLabel() const;
    Q_INVOKABLE void unitLabel(const QString& unitLabel);
    Q_INVOKABLE QString deviceModel() const;
    Q_INVOKABLE void deviceModel(const QString& deviceModel);

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
