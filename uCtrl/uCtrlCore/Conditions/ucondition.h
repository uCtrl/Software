#ifndef UCONDITION_H
#define UCONDITION_H
#include <QString>

class UCondition
{
public:
    UCondition(QString type);

    QString type() const {
        return m_type;
    }

private:
    QString m_type;
};

#endif // UCONDITION_H
