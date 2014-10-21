#ifndef UDEVICE_H
#define UDEVICE_H

#include "Models/nestedlistitem.h"
#include "Models/nestedlistmodel.h"
#include "Scenario/uscenariosmodel.h"

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
    int type() const;
    void type(int type);
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
    int status() const;
    void status(int status);
    QString unitLabel() const;
    void unitLabel(const QString& unitLabel);

private:
    QString m_name;
    int m_type;
    QString m_description;
    QString m_maxValue;
    QString m_minValue;
    QString m_value;
    int m_precision;
    int m_status;
    QString m_unitLabel;
    NestedListModel* m_scenarios;
};

#endif // UDEVICE_H
