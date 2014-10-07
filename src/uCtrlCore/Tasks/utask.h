#ifndef UTASK_H
#define UTASK_H

#include "Conditions/ucondition.h"
#include <QAbstractListModel>

class UTask : public QAbstractListModel, public JsonSerializable
{
    Q_OBJECT

    Q_PROPERTY(QString id READ getId WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QList<UCondition*> conditions READ getConditions WRITE setConditions NOTIFY conditionsChanged)
    Q_PROPERTY(QObject* scenario READ getScenario WRITE setScenario NOTIFY scenarioChanged)

public:
    UTask() {}
    UTask(QObject* parent);
    UTask(QObject* parent, const QString& id);
    UTask(QObject* parent, UTask* task);
    ~UTask();

    QString getId() const
    {
        return m_id;
    }

    QList<UCondition*> getConditions() const
    {
        return m_conditions;
    }

    QObject* getScenario() const
    {
        return m_scenario;
    }

    Q_INVOKABLE int conditionCount() const
    {
        return m_conditions.count();
    }

    // TODO : Handle condition type when it's implemented
    Q_INVOKABLE QObject* createCondition(int conditionType);
    Q_INVOKABLE void addCondition(UCondition* condition);
    Q_INVOKABLE QObject* getConditionAt(int index) const;
    Q_INVOKABLE void deleteConditionAt(int index);
    Q_INVOKABLE void moveCondition(int indexSource, int indexDestination);
    QList<UCondition*> copyConditions();
    Q_INVOKABLE UCondition* findCondition(const QString& conditionId);
    Q_INVOKABLE bool containsCondition(const QString& conditionId);
    Q_INVOKABLE void deleteCondition(const QString& conditionId);
    Q_INVOKABLE QObject* getAllDevices();

    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const
    {
        return m_conditions.count();
    }

    virtual QVariant data(const QModelIndex &index, int role) const
    {
        return QVariant();
    }

    void read(const QJsonObject &jsonObj);
    void write(QJsonObject &jsonObj) const;

public slots:

    void setId(QString arg)
    {
        if (m_id != arg) {
            m_id = arg;
            emit idChanged(arg);
        }
    }

    void setConditions(QList<UCondition*> arg)
    {
        if (m_conditions != arg) {
            m_conditions = arg;
            emit conditionsChanged(arg);
        }
    }

    void setScenario(QObject* arg)
    {
        if (m_scenario != arg) {
            m_scenario = arg;
            this->setParent(arg);
            emit scenarioChanged(arg);
        }
    }

signals:
    void idChanged(QString arg);
    void conditionsChanged(QList<UCondition*> arg);
    void scenarioChanged(QObject* arg);

private:
    QString m_id;
    QList<UCondition*> m_conditions;
    QObject* m_scenario;
};

#endif // UTASK_H
