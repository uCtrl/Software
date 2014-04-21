#ifndef USCENARIO_H
#define USCENARIO_H

#include "Serialization/jsonserializable.h"
#include "Tasks/utask.h"
#include "Conditions/ucondition.h"
#include <QAbstractListModel>
#include "Device/udevice.h"

class UDevice;

class UScenario : public QAbstractListModel, public JsonSerializable
{
    Q_OBJECT

    Q_PROPERTY(int id READ getId WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString name READ getName WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QList<UTask*> tasks READ getTasks WRITE setTasks NOTIFY tasksChanged)
    Q_PROPERTY(QObject* device READ getDevice NOTIFY deviceChanged)

public:
    UScenario() {}
    UScenario(QObject *parent);
    UScenario(UScenario* scenario);
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
    Q_INVOKABLE void moveTask(int indexSource, int indexDestination);
    Q_INVOKABLE QObject* copyScenario() { return new UScenario(this); }
    Q_INVOKABLE void updateScenario(UScenario* scenario);
    QList<UTask*> copyTasks();

    void read(const QJsonObject &jsonObj);
    void write(QJsonObject &jsonObj) const;

    QObject* getDevice() const
    {
        return m_device;
    }

public slots:

    void setId(int arg)
    {
        if (m_id != arg) {
            m_id = arg;
            emit idChanged(arg);
        }
    }

    void setName(QString arg)
    {
        if (m_name != arg) {
            m_name = arg;
            emit nameChanged(arg);
        }
    }

    void setTasks(QList<UTask*> arg)
    {
        if (m_tasks != arg) {
            m_tasks = arg;
            emit tasksChanged(arg);
        }
    }

signals:
    void tasksChanged(QList<UTask*> arg);

    void idChanged(int arg);

    void nameChanged(QString arg);

    void deviceChanged(QObject* arg);

private:
    int m_id;
    QString m_name;
    QList<UTask*> m_tasks;
    QObject* m_device;
};
#endif // USCENARIO_H
