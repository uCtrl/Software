#ifndef USYSTEM_H
#define USYSTEM_H

#include "Serialization/JsonMacros.h"
#include "Platform/uplatform.h"
#include <QList>
#include <QAbstractListModel>


class USystem: public QAbstractListModel
{
    Q_PROPERTY(QList<UPlatform*> platforms READ getPlatforms WRITE setPlatforms)
    UCTRL_JSON(USystem)
public:
    USystem(QObject* parent = 0);
//    USystem(const USystem& system);
    ~USystem();


    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual int rowCount(const QModelIndex &parent) const;

    QList<UPlatform*> getPlatforms() const { return m_platforms; }

public slots:
    void setPlatforms(QList<UPlatform*> arg) { m_platforms = arg; }

private:
    QList<UPlatform*> m_platforms;

};

#endif // USYSTEM_H
