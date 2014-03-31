#ifndef UTASK_H
#define UTASK_H

#include "Conditions/ucondition.h"
#include <QAbstractListModel>

class UTask : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(int id READ getId WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString status READ getStatus WRITE setStatus NOTIFY statusChanged)
    Q_PROPERTY(QList<UCondition*> conditions READ getConditions WRITE setConditions NOTIFY conditionsChanged)
    Q_PROPERTY(QObject* scenario READ getScenario)

public:
    UTask( QObject* parent);
    UTask( const UTask* task );
    ~UTask();

    int getId() const { return m_id; }

    QString getStatus() const { return m_status; }

    QList<UCondition*> getConditions() const { return m_conditions; }

    QObject* getScenario() const { return m_scenario;}

    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const { return m_conditions.count(); }
    virtual QVariant data(const QModelIndex &index, int role) const { return QVariant(); }

    Q_INVOKABLE int conditionCount() const { return m_conditions.count(); }
    // TODO : Handle condition type when it's implemented
    Q_INVOKABLE QObject* createCondition();
    Q_INVOKABLE void addCondition(UCondition* condition);
    Q_INVOKABLE QObject* getConditionAt(int index) const;
    Q_INVOKABLE void deleteConditionAt(int index);
    Q_INVOKABLE void moveCondition(int indexSource, int indexDestination);

    void read(const QJsonObject &jsonObj);
    void write(QJsonObject &jsonObj) const;

public slots:

    void setId(int arg)
    {
        if (m_id != arg) {
            m_id = arg;
            emit idChanged(arg);
        }
    }

    void setStatus(QString arg)
    {
        if (m_status != arg) {
            m_status = arg;
            emit statusChanged(arg);
        }
    }

    void setConditions(QList<UCondition*> arg)
    {
        if (m_conditions != arg) {
            m_conditions = arg;
            emit conditionsChanged(arg);
        }
    }

signals:
    void idChanged(int arg);
    void statusChanged(QString arg);
    void conditionsChanged(QList<UCondition*> arg);

private:
    int m_id;
    QList<UCondition*> m_conditions;
    QString m_status;
    QObject* m_scenario;
};

#endif // UTASK_H
