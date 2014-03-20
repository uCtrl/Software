#ifndef USCENARIOMODEL_H
#define USCENARIOMODEL_H

#include <QAbstractListModel>
#include "Tasks/utask.h"
#include "../Models/Task/utaskmodel.h"
#include "Scenario/uscenario.h"

class UScenarioModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)

signals:
    void nameChanged(QString);

public:
    enum TaskRoles {
        IdRole = Qt::UserRole + 1,
        StatusRole
    };

    UScenarioModel(QObject *parent = 0);
    UScenarioModel(const UScenario* scenario, QObject *parent = 0);
    UScenarioModel(const UScenarioModel& scenarioModel, QObject *parent = 0);
    // #???
    //UScenarioModel(const UScenarioBuilder* scenarioBuilder, QObject *parent = 0);
    ~UScenarioModel();

private:
    // #???
    //const UScenarioBuilder* m_scenarioBuilder;
    const UScenario*        m_scenario;

public:
    // Q_Property related methods
    QString name();
    void setName(QString);

    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual QHash<int, QByteArray> roleNames() const;

    Q_INVOKABLE QObject *getTaskAt(const QString &index) const;
    Q_INVOKABLE QList<QObject*> getTasks() const;

};

#endif // USCENARIOMODEL_H
