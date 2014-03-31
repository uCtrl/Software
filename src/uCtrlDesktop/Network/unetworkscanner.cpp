#include "unetworkscanner.h"

UNetworkScanner* UNetworkScanner::m_networkScanner = NULL;

UNetworkScanner* UNetworkScanner::Instance()
{
    if(!m_networkScanner)
        m_networkScanner = new UNetworkScanner();

    return m_networkScanner;
}

UNetworkScanner::UNetworkScanner()
{
    m_bonjourBrowser = new BonjourServiceBrowser(this);
    connect(m_bonjourBrowser, SIGNAL(newBonjourRecord(const BonjourRecord&)), this, SLOT(resolveService(const BonjourRecord&)));
}

void UNetworkScanner::scanNetwork()
{
    m_bonjourBrowser->browseForServiceType("_uctrl._tcp");
}

void UNetworkScanner::resolveService(const BonjourRecord& record)
{
    BonjourServiceResolver* resolver = new BonjourServiceResolver(this);

    connect(resolver, SIGNAL(bonjourRecordResolved(const QHostInfo &, int)), this, SLOT(resolved(const QHostInfo &, int)));

    resolver->resolveBonjourRecord(record);
}

void UNetworkScanner::resolved(const QHostInfo &hostInfo, int port)
{
    const QList<QHostAddress>& addresses = hostInfo.addresses();
    if (!addresses.isEmpty()) {
        qDebug() << "Address: " << addresses.first().toString() << " Port: " << QString::number(port);

        USystem::Instance()->addPlatform(addresses.first().toString(), port);
    }
}

