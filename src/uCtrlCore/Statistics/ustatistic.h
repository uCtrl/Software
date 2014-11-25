#ifndef USTATISTIC_H
#define USTATISTIC_H

#include "Models/nestedlistitem.h"

class UStatistic : public ListItem
{
    Q_OBJECT

    enum UStatisticRoles
    {
        idRole = Qt::UserRole + 1,
        dataRole,
        typeRole,
        timestampRole
    };

public:
    explicit UStatistic(QObject *parent = 0);
    ~UStatistic();

    // NestedListItem
    QVariant data(int role) const;
    bool setData(const QVariant &value, int role);
    QHash<int, QByteArray> roleNames() const;

    // JsonSerializable
    void write(QJsonObject &jsonObj) const;
    void read(const QJsonObject &jsonObj);

    // Properties
    QString data() const;
    void data(const QString& data);
    int type() const;
    void type(int type);
    double timestamp() const;
    void timestamp(double timestamp);

private:
    QString m_data;
    bool m_type;
    double m_timestamp;
};

#endif // USTATISTIC_H
