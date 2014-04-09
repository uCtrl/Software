#include "uconditiontime.h"

UConditionTime::UConditionTime(QObject* parent, QTime beginTime, QTime endTime)
    : UCondition(parent, UEConditionType::Time)
{
    setBeginTime(beginTime);
    setEndTime(endTime);
}

void UConditionTime::read(const QJsonObject &jsonObj)
{
    UCondition::read(jsonObj);

    QString beginTimeStr = jsonObj["beginTime"].toString();
    QTime tmp = QTime::fromString(beginTimeStr, "hh:mm");
    setBeginTime(tmp);

    tmp = QTime::fromString(jsonObj["endTime"].toString(), "hh:mm");
    setEndTime(tmp);
}

void UConditionTime::write(QJsonObject &jsonObj) const
{
    UCondition::write(jsonObj);
    jsonObj["beginTime"] = m_beginTime.toString();
    jsonObj["endTime"] = m_endTime.toString();
}
