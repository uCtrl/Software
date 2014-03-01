#ifndef USCENARIO_H
#define USCENARIO_H

#include <QAbstractListModel>
#include "../Tasks/utask.h"

class UScenario : public QAbstractListModel
{
    Q_OBJECT

public slots:
     void cppSlot() {
         this->addTask(UTask(34));
     }

public:
    enum TaskRoles {
        IdRole = Qt::UserRole + 1
    };

    UScenario(QObject *parent = 0);

    void addTask(const UTask &animal);

    int rowCount(const QModelIndex & parent = QModelIndex()) const;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QHash<int, QByteArray> roleNames() const;
private:
    QList<UTask> m_tasks;
};

#endif // USCENARIO_H
