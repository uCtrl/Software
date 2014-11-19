#include "recommendation.h"

Recommendation::Recommendation(QObject* parent) : ListItem(parent)
{
}

Recommendation::~Recommendation()
{
}

QVariant Recommendation::data(int role) const
{
    switch (role)
    {
    case idRole:
        return id();
    case descriptionRole:
        return description();
    default:
        return QVariant();
    }
}

bool Recommendation::setData(const QVariant& value, int role)
{
    switch (role)
    {
    case idRole:
        id(value.toString());
        break;
    case descriptionRole:
        description(value.toString());
        break;
    default:
        return false;
    }
    return true;
}

QHash<int, QByteArray> Recommendation::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[idRole] = "id";
    roles[descriptionRole] = "description";

    return roles;
}

void Recommendation::write(QJsonObject& jsonObj) const
{
    jsonObj["id"] = this->id();
    jsonObj["description"] = this->description();
}

void Recommendation::read(const QJsonObject& jsonObj)
{
    this->id(jsonObj["id"].toString());
    this->description(jsonObj["description"].toString());
}

QString Recommendation::description() const
{
    return m_description;
}

void Recommendation::description(const QString &description)
{
    if (m_description != description) {
        m_description = description;
        emit dataChanged();
    }
}

