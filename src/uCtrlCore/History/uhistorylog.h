#ifndef UHISTORYLOG_H
#define UHISTORYLOG_H

#include "Models/listmodel.h"
#include "Models/listitem.h"

class UHistoryLog : public ListItem
{
    Q_OBJECT

    enum HistoryLogRoles
    {
        typeRole = Qt::UserRole + 1,
        severityRole,
        messageRole,
        timestampRole
    };

public:
    Q_ENUMS(UELogType)

    enum class UELogType: int {
        Action,
        Status,
        Condition,
        Update,
        Scenario,
        Other,
    };

    enum class UESeverity: int {
        Normal,
        Inactive,
        Warning,
        Error,
        Other,
    };

    explicit UHistoryLog(QObject *parent = 0);
    explicit UHistoryLog(UELogType type, UESeverity severity, QString message, QDateTime date, QObject *parent = 0);
    ~UHistoryLog();
    ListModel* nestedModel() const;

    // NestedListItem
    QVariant data(int role) const;
    bool setData(const QVariant &value, int role);
    QHash<int, QByteArray> roleNames() const;

    // JsonSerializable
    void write(QJsonObject &jsonObj) const;
    void read(const QJsonObject &jsonObj);

    // Properties
    UELogType type() const;
    void type(const UELogType& type);

    UESeverity severity() const;
    void severity(const UESeverity& severity);

    QString message() const;
    void message(const QString& message);

    QString timestamp() const;
    void timestamp(const QDateTime& type);


private:
    UELogType m_type;
    UESeverity m_severity;
    QString m_message;
    QDateTime m_timestamp;
};

#endif // UHISTORYLOG_H
