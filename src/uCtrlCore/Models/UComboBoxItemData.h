#ifndef UCOMBOBOXITEMDATA_H
#define UCOMBOBOXITEMDATA_H

#include <QAbstractItemModel>

class UComboBoxItemData : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(QString value READ getValue WRITE setValue NOTIFY valueChanged)
    Q_PROPERTY(QString displayedValue READ getDisplayedValue WRITE setDisplayedValue NOTIFY displayedValueChanged)
    Q_PROPERTY(QString iconId READ getIconId WRITE setIconId NOTIFY iconIdChanged)

    QString m_value;
    QString m_displayedValue;
    QString m_iconId;

public:

    virtual QVariant data(const QModelIndex &index, int role) const { return QVariant(); }
    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const { return 1; }

    QString getValue() const
    {
        return m_value;
    }

    QString getDisplayedValue() const
    {
        return m_displayedValue;
    }

    QString getIconId() const
    {
        return m_iconId;
    }

public slots:

    void setValue(QString arg)
    {
        if (m_value != arg) {
            m_value = arg;
            emit valueChanged(arg);
        }
    }

    void setDisplayedValue(QString arg)
    {
        if (m_displayedValue != arg) {
            m_displayedValue = arg;
            emit displayedValueChanged(arg);
        }
    }

    void setIconId(QString arg)
    {
        if (m_iconId != arg) {
            m_iconId = arg;
            emit iconIdChanged(arg);
        }
    }

signals:

    void valueChanged(QString arg);
    void displayedValueChanged(QString arg);
    void iconIdChanged(QString arg);

};

#endif // UCOMBOBOXITEMDATA_H
