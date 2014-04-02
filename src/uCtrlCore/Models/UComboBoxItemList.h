#ifndef UCOMBOBOXITEMLIST_H
#define UCOMBOBOXITEMLIST_H

#include <QAbstractListModel>
#include "UComboBoxItemData.h"

class UComboBoxItemList : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(QList<UComboBoxItemData*> comboBoxItemDatas READ getComboBoxItemDatas WRITE setComboBoxItemDatas NOTIFY comboBoxItemDatasChanged)
    Q_PROPERTY(QObject* selectedItem READ getSelectedItem WRITE setSelectedItem NOTIFY selectedItemChanged)
public:
    UComboBoxItemList(QList<UComboBoxItemData*>& comboBoxItemDatas) : m_selectedItem(NULL) {
        m_comboBoxItemDatas = comboBoxItemDatas;

        if (m_comboBoxItemDatas.size() > 0) {
            m_selectedItem = comboBoxItemDatas.at(0);
        }
    }

    virtual QVariant data(const QModelIndex &index, int role) const { return QVariant();}
    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const { return m_comboBoxItemDatas.count();}
    Q_INVOKABLE QObject* getItemDataAt(int index) { return m_comboBoxItemDatas.at(index); }

    QList<UComboBoxItemData*> getComboBoxItemDatas() const
    {
        return m_comboBoxItemDatas;
    }

    QObject* getSelectedItem() const
    {
        return m_selectedItem;
    }

public slots:
    void setComboBoxItemDatas(QList<UComboBoxItemData*> arg)
    {
        if (m_comboBoxItemDatas != arg) {
            m_comboBoxItemDatas = arg;
            emit comboBoxItemDatasChanged(arg);
        }
    }

    void setSelectedItem(QObject* arg)
    {
        if (m_selectedItem != arg) {
            m_selectedItem = arg;
            emit selectedItemChanged(arg);
        }
    }

signals:
    void comboBoxItemDatasChanged(QList<UComboBoxItemData*> arg);

    void selectedItemChanged(QObject* arg);

private:
    QList<UComboBoxItemData*> m_comboBoxItemDatas;
    QObject* m_selectedItem;
};

#endif // UCOMBOBOXITEMLIST_H
