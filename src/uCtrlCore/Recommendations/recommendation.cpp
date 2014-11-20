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
    case acceptedRole:
        return accepted();
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
    case acceptedRole:
        accepted(value.toBool());
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
    roles[acceptedRole] = "accepted";

    return roles;
}

void Recommendation::write(QJsonObject& jsonObj) const
{
    jsonObj["id"] = this->id();
    jsonObj["description"] = this->description();
    jsonObj["accepted"] = this->accepted();
}

void Recommendation::read(const QJsonObject& jsonObj)
{
    this->id(jsonObj["id"].toString());
    this->description(jsonObj["description"].toString());
    this->accepted(jsonObj["accepted"].toBool());
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

bool Recommendation::accepted() const
{
    return m_accepted;
}

void Recommendation::accepted(bool accepted)
{
    if (m_accepted != accepted) {
        m_accepted = accepted;
        emit dataChanged();
    }
}

