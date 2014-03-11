#ifndef UTaskModel_H
#define UTaskModel_H

#include <QAbstractListModel>
#include "Tasks/utask.h"

class UTaskModel : public QAbstractListModel
{
    Q_OBJECT 

public:
    enum TaskRoles {
        idRole = Qt::UserRole + 1
    };

    ~UTaskModel();
    UTaskModel(const UTask* task, QObject *parent = 0);

private:
    const UTask* m_task;

public:
    void addCondition(const UCondition *cond);
    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual QHash<int, QByteArray> roleNames() const; 

    Q_INVOKABLE const UCondition* getConditionAt(const QString &index) const;
};

#endif // UTaskModel_H
