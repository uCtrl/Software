#include "listmodel.h"

ListModel::ListModel(ListItem* prototype, QObject* parent) : QAbstractListModel(parent)
{
   QQmlEngine::setObjectOwnership(this, QQmlEngine::CppOwnership);
   m_prototype = prototype;
   m_items = QList<ListItem*>();
}

ListModel::~ListModel()
{
    delete m_prototype;
    m_prototype = NULL;
    clear();
}

int ListModel::rowCount(const QModelIndex&) const
{
    return this->m_items.size();
}

QVariant ListModel::data(const QModelIndex& index, int role) const
{
    if (index.row() < 0 || index.row() >= m_items.size())
        return QVariant();

    return m_items.at(index.row())->data(role);
}

bool ListModel::setData(const QModelIndex& index, const QVariant& value, int role)
{
    if(index.row() < 0 || index.row() >= m_items.size())
       return false;

     return m_items.at(index.row())->setData(value, role);
}

Qt::ItemFlags ListModel::flags(const QModelIndex& index) const
{
    if (!index.isValid())
        return Qt::ItemIsEnabled;

    return QAbstractListModel::flags(index) | Qt::ItemIsEditable;
}

QHash<int, QByteArray> ListModel::roleNames() const
{
    return this->m_prototype->roleNames();
}

QVariant ListModel::get(int index)
{
    if (index >= m_items.size() || index < 0)
        return QVariant();

    ListItem* item = m_items.at(index);
    QMap<QString, QVariant> itemData;
    QHashIterator<int, QByteArray> hashItr(item->roleNames());

    while(hashItr.hasNext())
    {
        hashItr.next();
        itemData.insert(hashItr.value(),QVariant(item->data(hashItr.key())));
    }
    return QVariant(itemData);
}

void ListModel::appendRow(ListItem* item)
{
    if (item == NULL)
        return;

    appendRows(QList<ListItem *>() << item);
}

void ListModel::appendRows(const QList<ListItem*>& items)
{
    if (items.size() == 0)
        return;

    beginInsertRows(QModelIndex(), rowCount(), rowCount() + items.size());

    foreach(ListItem* item, items)
    {
        QObject::connect(item, SIGNAL(dataChanged()), this, SLOT(updateItem()));
        m_items.append(item);
    }

    endInsertRows();
}

void ListModel::insertRow(int row, ListItem* item)
{
    if (item == NULL)
        return;

    beginInsertRows(QModelIndex(), row, row + 1);

    QObject::connect(item, SIGNAL(dataChanged()), this, SLOT(updateItem()));
    m_items.insert(row, item);

    endInsertRows();
}

bool ListModel::moveRow(int from, int to)
{
    if (from < 0 || from >= m_items.size() || to < 0 || to >= m_items.size() || from == to)
        return false;

    beginMoveRows(QModelIndex(), from, from, QModelIndex(), from > to ? to : to + 1);

    m_items.move(from, to);

    endMoveRows();
    return true;
}

bool ListModel::moveUp(int from)
{
    return moveRow(from, from+1);
}

bool ListModel::moveDown(int from)
{
    return moveRow(from, from-1);
}

bool ListModel::removeRow(int row, const QModelIndex& index)
{
    return removeRows(row, 1, index);
}

bool ListModel::removeRows(int row, int count, const QModelIndex& index)
{
    if (row < 0 || count <= 0 || (row + count) > m_items.size())
        return false;

    beginRemoveRows(index, row, row + count - 1);

    for (int i = 0; i < count; i++)
    {
        ListItem* item = m_items.takeAt(row);
        delete item;
        item = NULL;
    }

    endRemoveRows();
    return true;
}

ListItem* ListModel::takeRow(int row, const QModelIndex &index)
{
    if (row < 0 || row >= m_items.size())
        return NULL;

    beginRemoveRows(index, row, row);

    ListItem *item = m_items.takeAt(row);

    endRemoveRows();

    return item;
}

ListItem* ListModel::find(const QString& itemId) const
{
    foreach(ListItem *item, m_items) {
        if (item->id() == itemId)
            return item;
    }
    return NULL;
}

QObject *ListModel::findObject(const QString &itemId) const
{
    return find(itemId);
}

void ListModel::clear()
{
    if (m_items.size() == 0)
        return;

    removeRows(0, m_items.size());
}

QModelIndex ListModel::indexFromItem(ListItem *item) const
{
    if (item != NULL)
    {
        for (int i = 0; i < m_items.size(); i++) {
            if (m_items.at(i) == item)
                return index(i);
        }
    }
    return QModelIndex();
}

int ListModel::indexOf(ListItem *item) const
{
    if (item != NULL)
    {
        for (int i = 0; i < m_items.size(); i++) {
            if (m_items.at(i) == item)
                return i;
        }
    }
    return -1;
}

void ListModel::updateItem()
{
    ListItem* item = static_cast<ListItem*>(sender());
    QModelIndex index = this->indexFromItem(item);
    if (index.isValid())
        emit dataChanged(index, index);
}
