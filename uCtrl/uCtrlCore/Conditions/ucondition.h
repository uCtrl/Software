#ifndef UCONDITION_H
#define UCONDITION_H
#include <QString>
class UCondition
{
public:
    UCondition(QString type, QString name);

    QString type() const {
        return m_type;
    }
    QString name() const{
        return m_name;
    }

private:
    QString m_type;
    QString m_name;
};

#endif // UCONDITION_H
