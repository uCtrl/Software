#ifndef RECOMMENDATION_H
#define RECOMMENDATION_H

#include "Models/nestedlistitem.h"

class Recommendation : public ListItem
{
    Q_OBJECT

    enum RecommendationRoles
    {
        idRole = Qt::UserRole + 1,
        descriptionRole,
        acceptedRole
    };

public:
    explicit Recommendation(QObject *parent = 0);
    ~Recommendation();

    // NestedListItem
    QVariant data(int role) const;
    bool setData(const QVariant &value, int role);
    QHash<int, QByteArray> roleNames() const;

    // JsonSerializable
    void write(QJsonObject &jsonObj) const;
    void read(const QJsonObject &jsonObj);

    // Properties
    QString description() const;
    void description(const QString& description);
    bool accepted() const;
    void accepted(bool accepted);

private:
    QString m_description;
    bool m_accepted;
};

#endif // RECOMMENDATION_H
