#ifndef USCENARIO_H
#define USCENARIO_H

#include <QAbstractListModel>
#include "../Tasks/utask.h"

class UScenario : public QAbstractListModel
{
    Q_OBJECT

public slots:
     void cppSlot() { // Used to test the insertion from UI
         this->addTask(new UTask());
     }

public:
    enum TaskRoles {
        IdRole = Qt::UserRole + 1
    };

    UScenario(QObject *parent = 0);

private:
    QList<UTask*> m_tasks;

public:
    void addTask(UTask* task);
    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual QHash<int, QByteArray> roleNames() const;

    // Make sure you define a destructor for UScenario
    ~UScenario();
};

#endif // USCENARIO_H
