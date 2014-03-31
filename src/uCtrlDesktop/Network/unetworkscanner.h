#ifndef UNETWORKSCANNER_H
#define UNETWORKSCANNER_H

#include "Network/bonjourservicebrowser.h"
#include "Network/bonjourserviceresolver.h"
#include "System/usystem.h"
#include <QHostInfo>
#include <QObject>


class UNetworkScanner : public QObject
{
    Q_OBJECT

public:
    static UNetworkScanner* Instance();
    void scanNetwork();

private slots:
    void resolveService(const BonjourRecord& record);
    void resolved(const QHostInfo &adresses, int port);

private:
    UNetworkScanner();

    static UNetworkScanner* m_networkScanner;
    BonjourServiceBrowser* m_bonjourBrowser;
};

#endif // UNETWORKSCANNER_H
