#ifndef UCONDITIONTIME_H
#define UCONDITIONTIME_H

#include "ucondition.h"
#include <QDateTime>

class UConditionTime : public UCondition {
    Q_OBJECT

public:
    Q_PROPERTY(QTime beginTime READ getBeginTime WRITE setBeginTime NOTIFY beginTimeChanged)
    Q_PROPERTY(QTime endTime READ getEndTime WRITE setEndTime NOTIFY endTimeChanged)

    UConditionTime(QObject* parent, QTime beginTime = QTime::currentTime(), QTime endTime = QTime::currentTime());

    QTime getBeginTime() const
    {
        return m_beginTime;
    }
    QTime getEndTime() const
    {
        return m_endTime;
    }

    Q_INVOKABLE void setBeginTime(QString arg)
    {
        QTime newTime = QTime::fromString(arg, "hh:mm");
        setBeginTime(newTime);
    }

    Q_INVOKABLE void setEndTime(QString arg)
    {
        QTime newTime = QTime::fromString(arg, "hh:mm");
        setEndTime(newTime);
    }

    void read(const QJsonObject &jsonObj);
    void write(QJsonObject &jsonObj) const;

public slots:

    void setBeginTime(QTime arg)
    {
        if (m_beginTime != arg) {
            m_beginTime = arg;
            emit beginTimeChanged(arg);
        }
    }

    void setEndTime(QTime arg)
    {
        if (m_endTime != arg) {
            m_endTime = arg;
            emit endTimeChanged(arg);
        }
    }

signals:
    void beginTimeChanged(QTime arg);
    void endTimeChanged(QTime arg);

private:
    QTime m_beginTime;
    QTime m_endTime;
};

#endif // UCONDITIONTIME_H
