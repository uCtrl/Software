#ifndef UDEVICE_H
#define UDEVICE_H

#include "Models/nestedlistitem.h"
#include "Models/nestedlistmodel.h"
#include "Scenario/uscenario.h"

class UDevice : public NestedListItem
{
    Q_OBJECT

    enum DeviceRoles
    {
        idRole = Qt::UserRole + 1,
        typeRole,
        descriptionRole,
        enabledRole,
        isTriggerValueRole,
        maxValueRole,
        minValueRole,
        nameRole,
        precisionRole,
        statusRole,
        unitLabelRole
    };

public:
    explicit UDevice(QObject *parent = 0);
    ~UDevice();

    // NestedListItem
    QVariant data(int role) const;
    bool setData(const QVariant &value, int role);
    QHash<int, QByteArray> roleNames() const;
    ListModel* nestedModel() const;

    // Properties
    inline QString id() const { return m_id; }
    inline void id(const QString& id) { m_id = id; emit dataChanged(); }
    inline int type() const{ return m_type; }
    inline void type(int type) { m_type = type; emit dataChanged(); }
    inline QString description() const { return m_description; }
    inline void description(const QString& description) { m_description = description; emit dataChanged(); }
    inline bool enabled() const { return m_enabled; }
    inline void enabled(bool enabled) { m_enabled = enabled; emit dataChanged(); }
    inline bool isTriggerValue() const { return m_isTriggerValue; }
    inline void isTriggerValue(bool isTriggerValue) { m_isTriggerValue = isTriggerValue; emit dataChanged(); }
    inline int maxValue() const{ return m_maxValue; }
    inline void maxValue(int maxValue) { m_maxValue = maxValue; emit dataChanged(); }
    inline int minValue() const{ return m_minValue; }
    inline void minValue(int minValue) { m_minValue = minValue; emit dataChanged(); }
    inline QString name() const { return m_name; }
    inline void name(const QString& name) { m_name = name; emit dataChanged(); }
    inline int precision() const{ return m_precision; }
    inline void precision(int precision) { m_precision = precision; emit dataChanged(); }
    inline int status() const{ return m_status; }
    inline void status(int status) { m_status = status; emit dataChanged(); }
    inline QString unitLabel() const { return m_unitLabel; }
    inline void unitLabel(const QString& unitLabel) { m_unitLabel = unitLabel; emit dataChanged(); }

private:
    QString m_id;
    int m_type;
    QString m_description;
    bool m_enabled;
    bool m_isTriggerValue;
    int m_maxValue;
    int m_minValue;
    QString m_name;
    int m_precision;
    int m_status;
    QString m_unitLabel;
    NestedListModel* m_scenarios;
};

#endif // UDEVICE_H
