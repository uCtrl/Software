#ifndef UDEVICEMODEL_H
#define UDEVICEMODEL_H

#include <QAbstractListModel>
#include "Device/udevice.h"
#include "Device/udevicebuilder.h"
#include "../Scenario/uscenariomodel.h"

class UDeviceModel : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(int ip READ ip WRITE setIp NOTIFY ipChanged)
    Q_PROPERTY(int type READ type WRITE setType NOTIFY typeChanged)

signals:
    void nameChanged(QString);
    void idChanged(int);
    void ipChanged(int);
    void typeChanged(int);

public:
    enum TaskRoles {
        IdRole = Qt::UserRole + 1,
        NameRole,
        IpRole
    };

    UDeviceModel(const UDeviceBuilder* deviceBuilder, QObject *parent = 0);
    ~UDeviceModel();

private:
    const UDeviceBuilder* m_deviceBuider;
    const UDevice* m_device;
    const UScenarioModel* m_scenarioModel;

public:
    void setScenarioModel(const UScenarioModel* model) { m_scenarioModel = model; }

    // Q_Property related methods
    QString name();
    void setName(QString);

    int id();
    void setId(int);

    int ip();
    void setIp(int);

    int type();
    void setType(int);

    const UDevice* device() {return m_device;}

    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual QHash<int, QByteArray> roleNames() const;

    Q_INVOKABLE QObject *getScenario() const;
};

#endif // UDEVICEMODEL_H
