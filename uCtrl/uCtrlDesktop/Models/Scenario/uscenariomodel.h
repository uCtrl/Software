#ifndef USCENARIOMODEL_H
#define USCENARIOMODEL_H

#include <QAbstractListModel>
#include "../../uCtrlCore/Tasks/utask.h"
#include "../../uCtrlCore/Scenario/uscenario.h"

class UScenarioModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum TaskRoles {
        IdRole = Qt::UserRole + 1,
        StatusRole
    };

    UScenarioModel(QObject *parent = 0);
    ~UScenarioModel();
    UScenarioModel(UScenario &scenario, QObject *parent = 0);

private:
    UScenario m_scenario;

public:
    void addTask(UTask* task);
    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual QHash<int, QByteArray> roleNames() const;
};

#endif // USCENARIOMODEL_H
