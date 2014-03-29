#ifndef USCENARIO_H
#define USCENARIO_H

#include "Serialization/JsonMacros.h"
#include "Tasks/utask.h"
#include "Conditions/ucondition.h"
#include <QAbstractListModel>

class UScenario : public QAbstractListModel
{
    Q_OBJECT
    UCTRL_JSON(UScenario)

    Q_PROPERTY(int id READ getId WRITE setId)
    Q_PROPERTY(QString name READ getName WRITE setName)
    Q_PROPERTY(QList<UTask*> tasks READ getTasks WRITE setTasks NOTIFY tasksChanged)

public:
    UScenario(QObject *parent);
    UScenario(const UScenario* scenario);
    ~UScenario();

    int getId() const { return m_id; }
    QString getName() const { return m_name; }
    QList<UTask*> getTasks() const { return m_tasks; }

    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const { return m_tasks.count(); }
    virtual QVariant data(const QModelIndex &index, int role) const { return QVariant(); }

    Q_INVOKABLE int taskCount() const { return m_tasks.count(); }
    // TODO : Verify if we can delete this from QML or javascript
    Q_INVOKABLE QObject* createTask();
    Q_INVOKABLE void addTask(UTask* task);
    Q_INVOKABLE QObject* getTaskAt(int index) const;
    Q_INVOKABLE void deleteTaskAt(int index);

public slots:
    void setId(int arg) { m_id = arg; }
    void setName(QString arg)
    {
        m_name = arg;
    }
    void setTasks(QList<UTask*> arg) { m_tasks = arg; }

signals:
    void tasksChanged(QList<UTask*> arg);

private:
    int m_id;
    QString m_name;
    QList<UTask*> m_tasks;
};
#endif // USCENARIO_H
