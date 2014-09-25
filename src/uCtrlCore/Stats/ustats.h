#ifndef USTATS_H
#define USTATS_H

#include "Serialization/jsonserializable.h"
#include "Communication/ucommunicationhandler.h"
#include <QAbstractListModel>
#include <QJsonObject>
#include <QList>

class UStats : public QAbstractListModel, public JsonSerializable
{
    Q_OBJECT
public:
    static UStats* Instance();

    virtual QVariant data(const QModelIndex &index, int role) const { return QVariant();}
    virtual int rowCount(const QModelIndex &parent) const { return 0; };

    void read(const QJsonObject &jsonObj);
    void write(QJsonObject &jsonObj) const;
private:
    UStats(){};
    static UStats* m_statsInstance;
};

#endif // USTATS_H
