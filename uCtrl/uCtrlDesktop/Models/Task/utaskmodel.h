#ifndef UTaskModel_H
#define UTaskModel_H

#include <QAbstractListModel>
#include "../../uCtrlCore/Tasks/utask.h"

class UTaskModel : public QAbstractListModel
{
    Q_OBJECT 

public:
    enum TaskRoles {
        typeRole = Qt::UserRole + 1
    };

    ~UTaskModel();
    UTaskModel(UTask &task, QObject *parent = 0);

private:
    UTask m_task;

public:
    void addCondition(UCondition *cond);
    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual QHash<int, QByteArray> roleNames() const; 
};

#endif // UTaskModel_H
