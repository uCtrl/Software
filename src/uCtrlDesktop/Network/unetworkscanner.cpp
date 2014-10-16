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
    m_localAdresses = QHostInfo::fromName(QHostInfo::localHostName()).addresses();
    m_bonjourBrowser = new BonjourServiceBrowser(this);
    connect(m_bonjourBrowser, SIGNAL(newBonjourRecord(const BonjourRecord&)), this, SLOT(resolveService(const BonjourRecord&)));
}

bool UNetworkScanner::isLocalAddress(QHostAddress& address)
{
    return m_localAdresses.contains(address);
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
    //USystem* system = USystem::Instance();
    QList<QHostAddress> addresses = hostInfo.addresses();
    for(int i = 0; i < addresses.count(); i++)
    {
        if(addresses[i].protocol() == QAbstractSocket::IPv4Protocol)
        {
            // There's no way (QT or c++) to get around the fact that localhost might have multiple interfaces.
            // Each interface has a diffrent ipv4, ipv6, link-local address. So, we will change every local
            // address to 127.0.0.1 (that corner case is impossible to happen in a µCtrl system.
            if(this->isLocalAddress(addresses[i]))
                addresses[i] = QHostAddress("127.0.0.1");

            /*if(!system->containsPlatform(addresses[i].toString(), port))
            {
                qDebug() << "Address: " << addresses[i].toString() << " Port: " << QString::number(port);
                system->addPlatform(addresses[i].toString(), port);
            }*/

            break;
        }
    }
}

