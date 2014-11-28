#ifndef LISTMODEL_H
#define LISTMODEL_H

#include <QAbstractListModel>
#include <QObject>
#include <QVariant>
#include <QList>
#include <QHash>
#include <QtQml/QQmlEngine>

#include "listitem.h"
#include "Serialization/jsonserializable.h"

class ListModel : public QAbstractListModel, public JsonSerializable
{
    Q_OBJECT

public:
    explicit ListModel(ListItem* prototype, QObject* parent = 0);
    ~ListModel();

    // QAbstractListModel
    Q_INVOKABLE int rowCount(const QModelIndex& parent = QModelIndex()) const;
    QVariant data(const QModelIndex& index, int role) const;
    bool setData(const QModelIndex& index, const QVariant& value, int role = Qt::EditRole);
    Qt::ItemFlags flags(const QModelIndex& index) const;
    QHash<int, QByteArray> roleNames() const;
    Q_INVOKABLE QVariant get(int row);

    // JsonSerializable
    virtual void write(QJsonObject &jsonObj) const = 0;
    virtual void read(const QJsonObject &jsonObj) = 0;

    // Helpers
    void appendRow(ListItem* item);
    void appendRows(const QList<ListItem*> &items);
    void insertRow(int row, ListItem* item);
    Q_INVOKABLE bool removeRow(int row, const QModelIndex& index = QModelIndex());
    Q_INVOKABLE bool removeRowWithId(const QString& id, const QModelIndex& index = QModelIndex());
    bool removeRows(int row, int count, const QModelIndex& index = QModelIndex());
    ListItem* takeRow(int row, const QModelIndex &index = QModelIndex());
    Q_INVOKABLE bool moveRow(int from, int to);
    Q_INVOKABLE bool moveUp(int from);
    Q_INVOKABLE bool moveDown(int from);
    Q_INVOKABLE QList<ListItem*> getItems() { return m_items; }

    Q_INVOKABLE QObject* getRow(int row);

    ListItem* find(const QString& itemId) const;
    Q_INVOKABLE QObject* findObject(const QString& itemId) const;
    Q_INVOKABLE QModelIndex indexFromItem(ListItem *item) const;
    Q_INVOKABLE int indexOf(ListItem *item) const;
    Q_INVOKABLE void clear();
    Q_INVOKABLE bool removeRow(const QString& itemId);

protected:
    ListItem* m_prototype;
    QList<ListItem*> m_items;

private slots :
    void updateItem();
};

#endif // LISTMODEL_H
