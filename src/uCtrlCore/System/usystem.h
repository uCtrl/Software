#ifndef USYSTEM_H
#define USYSTEM_H

#include "Platform/uplatform.h"
#include "Serialization/jsonserializable.h"
#include <QAbstractListModel>
#include <QJsonObject>
#include <QList>

class USystem : public QAbstractListModel, public JsonSerializable
{
    Q_OBJECT

public:
    static USystem* Instance();  

    Q_INVOKABLE QObject* getPlatformAt(int index) const;
    Q_PROPERTY(QList<UPlatform*> platforms READ getPlatforms WRITE setPlatforms NOTIFY platformsChanged)
 
    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual int rowCount(const QModelIndex &parent) const;

    QList<UPlatform*> getPlatforms() const { return m_platforms; }
    void addPlatform(const QString& ip, const int port);
    bool containsPlatform(const QString& ip, const int port);
    QObject* getAllDevices();

    void read(const QJsonObject &jsonObj);
    void write(QJsonObject &jsonObj) const;

public slots:
    void setPlatforms(QList<UPlatform*> arg) { m_platforms = arg; }

signals:
    void platformsChanged(QList<UPlatform*> arg);

private:
    USystem(){}
    static USystem* m_systemInstance;
    QList<UPlatform*> m_platforms;
};
#endif // USYSTEM_H
