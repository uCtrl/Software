#ifndef USCENARIO_H
#define USCENARIO_H

#include "Models/nestedlistitem.h"
#include "Models/nestedlistmodel.h"
#include "Task/utasksmodel.h"

class UScenario : public NestedListItem
{
    Q_OBJECT

    enum ScenarioRoles
    {
        idRole = Qt::UserRole + 1,
        nameRole,
        enabledRole,
        lastUpdatedRole
    };

public:
    explicit UScenario(QObject *parent = 0);
    ~UScenario();

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

private:
    QString m_name;
    NestedListModel* m_tasks;
};

#endif // USCENARIO_H
