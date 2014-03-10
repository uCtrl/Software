#ifndef USCENARIOMODEL_H
#define USCENARIOMODEL_H

#include <QAbstractListModel>
#include "Tasks/utask.h"
#include "Scenario/uscenario.h"
#include "Scenario/uscenariobuilder.h"

class UScenarioModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum TaskRoles {
        IdRole = Qt::UserRole + 1,
        StatusRole
    };

    UScenarioModel(QObject *parent = 0);
    UScenarioModel(const UScenarioBuilder* scenarioBuilder, QObject *parent = 0);
    ~UScenarioModel();

private:
    const UScenarioBuilder* m_scenarioBuilder;
    const UScenario*        m_scenario;

public:
    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual QHash<int, QByteArray> roleNames() const;

    Q_INVOKABLE QObject *getTaskAt(const QString &index) const;

};

#endif // USCENARIOMODEL_H
