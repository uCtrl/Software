#include "bonjourservicebrowser.h"

BonjourServiceBrowser::BonjourServiceBrowser(QObject *parent)
    : QObject(parent), m_dnssref(0), m_bonjourSocket(0)
{
}

BonjourServiceBrowser::~BonjourServiceBrowser()
{
    if (m_dnssref) {
        DNSServiceRefDeallocate(m_dnssref);
        m_dnssref = 0;
    }
}

void BonjourServiceBrowser::browseForServiceType(const QString &serviceType)
{
    DNSServiceErrorType err = DNSServiceBrowse(&m_dnssref, 0, 0, serviceType.toUtf8().constData(), 0,
                                               bonjourBrowseReply, this);
    if (err != kDNSServiceErr_NoError) {
        emit error(err);
    } else {
        int sockfd = DNSServiceRefSockFD(m_dnssref);
        if (sockfd == -1) {
            emit error(kDNSServiceErr_Invalid);
        } else {
            m_bonjourSocket = new QSocketNotifier(sockfd, QSocketNotifier::Read, this);
            connect(m_bonjourSocket, SIGNAL(activated(int)), this, SLOT(bonjourSocketReadyRead()));
        }
    }
}

void BonjourServiceBrowser::bonjourSocketReadyRead()
{
    DNSServiceErrorType err = DNSServiceProcessResult(m_dnssref);
    if (err != kDNSServiceErr_NoError)
        emit error(err);
}

void BonjourServiceBrowser::bonjourBrowseReply(DNSServiceRef , DNSServiceFlags flags,
                                               quint32 , DNSServiceErrorType errorCode,
                                               const char *serviceName, const char *regType,
                                               const char *replyDomain, void *context)
{
    BonjourServiceBrowser *serviceBrowser = static_cast<BonjourServiceBrowser *>(context);
    if (errorCode != kDNSServiceErr_NoError) {
        emit serviceBrowser->error(errorCode);
    } else {
        BonjourRecord bonjourRecord(serviceName, regType, replyDomain);
        if (flags & kDNSServiceFlagsAdd) {
            if (!serviceBrowser->m_bonjourRecords.contains(bonjourRecord))
                serviceBrowser->m_bonjourRecords.append(bonjourRecord);
        } else {
            serviceBrowser->m_bonjourRecords.removeAll(bonjourRecord);
        }
        if (!(flags & kDNSServiceFlagsMoreComing)) {
            emit serviceBrowser->currentBonjourRecordsChanged(serviceBrowser->m_bonjourRecords);
        }
    }
}

