#ifndef BONJOURRECORD_H
#define BONJOURRECORD_H

#include <QMetaType>
#include <QString>

// TODO Merge BonjourServiceResolver with BonjourRecord. Could be nice to have lookupHost à la
// http://qt-project.org/doc/qt-4.8/qhostinfo.html#lookupHost

class BonjourRecord
{
public:
    BonjourRecord() {}

    BonjourRecord(const QString &name, const QString &regType, const QString &domain)
        : serviceName(name), registeredType(regType), replyDomain(domain) {}

    BonjourRecord(const char *name, const char *regType, const char *domain) {
        serviceName = QString::fromUtf8(name);
        registeredType = QString::fromUtf8(regType);
        replyDomain = QString::fromUtf8(domain);
    }

    QString serviceName;
    QString registeredType;
    QString replyDomain;

    bool operator==(const BonjourRecord &other) const {
        return serviceName == other.serviceName
            && registeredType == other.registeredType
            && replyDomain == other.replyDomain;
    }
};

Q_DECLARE_METATYPE(BonjourRecord)

#endif // BONJOURRECORD_H
