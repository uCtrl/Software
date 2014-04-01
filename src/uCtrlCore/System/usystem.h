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

    Q_PROPERTY(QList<UPlatform*> platforms READ getPlatforms WRITE setPlatforms)

public:
    static USystem* Instance();

    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual int rowCount(const QModelIndex &parent) const;

    QList<UPlatform*> getPlatforms() const { return m_platforms; }
    void addPlatform(const QString& ip, const int port);
    bool containsPlatform(const QString& ip, const int port);

    void read(const QJsonObject &jsonObj);
    void write(QJsonObject &jsonObj) const;

public slots:
    void setPlatforms(QList<UPlatform*> arg) { m_platforms = arg; }

private:
    USystem(){}
    static USystem* m_systemInstance;
    QList<UPlatform*> m_platforms;
};
#endif // USYSTEM_H
