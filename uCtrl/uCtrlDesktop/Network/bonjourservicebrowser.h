#ifndef BONJOURBROWSER_H
#define BONJOURBROWSER_H

#include <QObject>
#include <QSocketNotifier>
#include <dns_sd.h>

#include "bonjourrecord.h"

class BonjourServiceBrowser : public QObject
{
    Q_OBJECT
public:
    BonjourServiceBrowser(QObject *parent = 0);
    ~BonjourServiceBrowser();
    void browseForServiceType(const QString &serviceType);
    inline QList<BonjourRecord> currentRecords() const { return m_bonjourRecords; }
    inline QString serviceType() const { return m_browsingType; }

signals:
    void currentBonjourRecordsChanged(const QList<BonjourRecord> &list);
    void error(DNSServiceErrorType err);

private slots:
    void bonjourSocketReadyRead();

private:
    static void DNSSD_API bonjourBrowseReply(DNSServiceRef , DNSServiceFlags flags, quint32,
                                             DNSServiceErrorType errorCode, const char *serviceName,
                                             const char *regType, const char *replyDomain, void *context);

    DNSServiceRef m_dnssref;
    QSocketNotifier *m_bonjourSocket;
    QList<BonjourRecord> m_bonjourRecords;
    QString m_browsingType;
};

#endif // BONJOURBROWSER_H
