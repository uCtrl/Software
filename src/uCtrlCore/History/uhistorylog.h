#ifndef UHISTORYLOG_H
#define UHISTORYLOG_H

#include "Models/listmodel.h"
#include "Models/listitem.h"

class UHistoryLog : public ListItem
{
    Q_OBJECT

    enum HistoryLogRoles
    {
        idRole = Qt::UserRole + 1,
        typeRole,
        severityRole,
        messageRole,
        timestampRole
    };

public:
    Q_ENUMS(UELogType)
    Q_ENUMS(UESeverity)

    enum class UELogType: int {
        Action,
        Status,
        Condition,
        Update,
        Scenario,
        Other
    };

    enum class UESeverity: int {
        Normal,
        Inactive,
        Warning,
        Error,
        Other
    };

    explicit UHistoryLog(QObject *parent = 0);
    ~UHistoryLog();

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

    double timestamp() const;
    void timestamp(double timestamp);

private:
    UELogType m_type;
    UESeverity m_severity;
    QString m_message;
    double m_timestamp;
};

#endif // UHISTORYLOG_H
