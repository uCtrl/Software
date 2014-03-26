#ifndef UTASK_H
#define UTASK_H

#include "../Serialization/JsonMacros.h"
#include "../Conditions/ucondition.h"
#include <QAbstractListModel>

class UTask: public QAbstractListModel
{
    Q_OBJECT


    int m_id;
    QList<UCondition*> m_conditions;
    QString m_status;

public:
    UTask( QObject* parent = 0 );
    UTask( const UTask* task );
    ~UTask();
    UCTRL_JSON(UTask)
    Q_PROPERTY(int id READ getId WRITE setId)
    Q_PROPERTY(QString status READ getStatus WRITE setStatus)
    Q_PROPERTY(QList<UCondition*> conditions READ getConditions WRITE setConditions)

    int getId() const { return m_id; }
    QList<UCondition*> getConditions() const { return m_conditions; }
    QString getStatus() const {
        return m_status;
    }

    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const { return m_conditions.count();}
    virtual QVariant data(const QModelIndex &index, int role) const { return QVariant();}

public slots:
    void setId(int arg) { m_id = arg; }
    void setConditions(QList<UCondition*> arg) { m_conditions = arg; }
    void setStatus(QString arg) { m_status = arg; }
};

#endif // UTASK_H
