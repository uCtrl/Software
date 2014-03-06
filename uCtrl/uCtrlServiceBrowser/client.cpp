#include <QtWidgets>
#include <QtNetwork>

#include "client.h"
#include "../uCtrlDesktop/Network/bonjourservicebrowser.h"
#include "../uCtrlDesktop/Network/bonjourserviceresolver.h"

Client::Client(QWidget *parent)
:   QDialog(parent), bonjourResolver(0)
{
    BonjourServiceBrowser *bonjourBrowser = new BonjourServiceBrowser(this);

    statusLabel = new QLabel(tr("This examples requires that you run a uCtrl service"));

    treeWidget = new QTreeWidget(this);
    treeWidget->setHeaderLabels(QStringList() << tr("Available uCtrl services"));
    connect(bonjourBrowser, SIGNAL(currentBonjourRecordsChanged(const QList<BonjourRecord> &)),
            this, SLOT(updateRecords(const QList<BonjourRecord> &)));
    resolveButton = new QPushButton(tr("Resolve"));
    resolveButton->setDefault(true);
    resolveButton->setEnabled(false);

    quitButton = new QPushButton(tr("Quit"));

    buttonBox = new QDialogButtonBox;
    buttonBox->addButton(resolveButton, QDialogButtonBox::ActionRole);
    buttonBox->addButton(quitButton, QDialogButtonBox::RejectRole);

    tcpSocket = new QTcpSocket(this);

    connect(resolveButton, SIGNAL(clicked()),
            this, SLOT(resolveService()));
    connect(quitButton, SIGNAL(clicked()), this, SLOT(close()));
    connect(tcpSocket, SIGNAL(error(QAbstractSocket::SocketError)),
            this, SLOT(displayError(QAbstractSocket::SocketError)));

    QGridLayout *mainLayout = new QGridLayout;
    mainLayout->addWidget(treeWidget, 0, 0, 2, 2);
    mainLayout->addWidget(statusLabel, 2, 0, 1, 2);
    mainLayout->addWidget(buttonBox, 3, 0, 1, 2);
    setLayout(mainLayout);

    setWindowTitle(tr("uCtrl Service Browser"));
    treeWidget->setFocus();
    bonjourBrowser->browseForServiceType(QLatin1String("_http._tcp")); // TODO Change the service type when we agree to one
}

void Client::resolveService()
{
    resolveButton->setEnabled(false);
    blockSize = 0;
    tcpSocket->abort();
    QList<QTreeWidgetItem *> selectedItems = treeWidget->selectedItems();
    if (selectedItems.isEmpty())
        return;

    if (!bonjourResolver) {
        bonjourResolver = new BonjourServiceResolver(this);
        connect(bonjourResolver, SIGNAL(bonjourRecordResolved(const QHostInfo &, int)),
                this, SLOT(connectToServer(const QHostInfo &, int)));
    }
    QTreeWidgetItem *item = selectedItems.at(0);
    QVariant variant = item->data(0, Qt::UserRole);
    bonjourResolver->resolveBonjourRecord(variant.value<BonjourRecord>());
}

void Client::connectToServer(const QHostInfo &hostInfo, int port)
{
    const QList<QHostAddress> &addresses = hostInfo.addresses();
    if (!addresses.isEmpty()) {
        statusLabel->setText("Address: " + addresses.first().toString() + " Port: " + QString::number(port));
    }
    enableResolveButton();
}

void Client::displayError(QAbstractSocket::SocketError socketError)
{
    switch (socketError) {
    case QAbstractSocket::RemoteHostClosedError:
        break;
    case QAbstractSocket::HostNotFoundError:
        QMessageBox::information(this, tr("uCtrl Service Browser"),
                                 tr("The host was not found. Please check the "
                                    "host name and port settings."));
        break;
    case QAbstractSocket::ConnectionRefusedError:
        QMessageBox::information(this, tr("uCtrl Service Browser"),
                                 tr("The connection was refused by the peer. "
                                    "Make sure the fortune server is running, "
                                    "and check that the host name and port "
                                    "settings are correct."));
        break;
    default:
        QMessageBox::information(this, tr("uCtrl Service Browser"),
                                 tr("The following error occurred: %1.")
                                 .arg(tcpSocket->errorString()));
    }
}

void Client::enableResolveButton()
{
    resolveButton->setEnabled(treeWidget->invisibleRootItem()->childCount() != 0);
}

void Client::updateRecords(const QList<BonjourRecord> &list)
{
    treeWidget->clear();
    foreach (BonjourRecord record, list) {
        QVariant variant;
        variant.setValue(record);
        QTreeWidgetItem *processItem = new QTreeWidgetItem(treeWidget,
                                                           QStringList() << "Type: " + record.registeredType +
                                                                            " Name: " + record.serviceName );
        processItem->setData(0, Qt::UserRole, variant);
    }

    if (treeWidget->invisibleRootItem()->childCount() > 0) {
        treeWidget->invisibleRootItem()->child(0)->setSelected(true);
    }

    enableResolveButton();
}

