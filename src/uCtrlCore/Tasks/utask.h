#ifndef UTASK_H
#define UTASK_H

#include "Conditions/ucondition.h"
#include <QAbstractListModel>

class UTask : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(int id READ getId WRITE setId)
    Q_PROPERTY(QString status READ getStatus WRITE setStatus NOTIFY statusChanged)
    Q_PROPERTY(QList<UCondition*> conditions READ getConditions WRITE setConditions)

public:
    UTask( QObject* parent);
    UTask( const UTask* task );
    ~UTask();

    int getId() const { return m_id; }
    QList<UCondition*> getConditions() const { return m_conditions; }
    void addCondition(UCondition *cond);
    QString getStatus() const { return m_status; }

    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const { return m_conditions.count(); }
    virtual QVariant data(const QModelIndex &index, int role) const { return QVariant(); }

    void read(const QJsonObject &jsonObj);
    void write(QJsonObject &jsonObj) const;

public slots:
    void setId(int arg) { m_id = arg; }
    void setConditions(QList<UCondition*> arg) { m_conditions = arg; }
    void setStatus(QString arg) { m_status = arg; }

signals:
    void statusChanged(QString arg);

private:
    int m_id;
    QList<UCondition*> m_conditions;
    QString m_status;
};

#endif // UTASK_H
