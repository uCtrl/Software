#ifndef UHISTORYLOG_H
#define UHISTORYLOG_H

#include "Models/nestedlistitem.h"
#include "Models/nestedlistmodel.h"

class uhistorylog : public NestedListItem
{
public:
    Q_OBJECT

    Q_ENUMS(UELogType)

    enum class UELogType: int {
        Action,
        Status,
        Condition,
        Update,
        Scenario,
        Other,
    };

    explicit uhistorylog(QObject *parent = 0);
    ~uhistorylog();

    // NestedListItem
    QVariant data(int role) const;
    bool setData(const QVariant &value, int role);
    QHash<int, QByteArray> roleNames() const;
    ListModel* nestedModel() const;

    // JsonSerializable
    void write(QJsonObject &jsonObj) const;
    void read(const QJsonObject &jsonObj);

    // Properties
    QString type() const;
    void type(const UELogType& type);

    QString message() const;
    void message(const QString& message);

    QString time() const;
    void time(const QDateTime& type);


private:
    UELogType m_type;
    QString m_message;
    QDateTime m_timestamp;
};

#endif // UHISTORYLOG_H
