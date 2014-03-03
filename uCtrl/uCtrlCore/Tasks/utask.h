#ifndef UTASK_H
#define UTASK_H
#include <QAbstractListModel>
#include "../Conditions/ucondition.h"

class UTask: public QAbstractListModel
{
    Q_OBJECT

public:
    enum TaskRoles {
        typeRole = Qt::UserRole + 1
    };

    UTask(QObject *parent = 0);
    ~UTask();
     int id() const{return m_id;}

private:
    int m_id;
    QList<UCondition*> m_conditions;

    // QAbstractItemModel interface
public:
    void addCondition(UCondition *cond);
    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual QHash<int, QByteArray> roleNames() const;
};


#endif // UTASK_H
