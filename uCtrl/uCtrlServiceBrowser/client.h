#ifndef CLIENT_H
#define CLIENT_H

#include <QDialog>
#include <QTreeWidget>
#include <QTcpSocket>

#include "../uCtrlDesktop/Network/bonjourrecord.h"

QT_BEGIN_NAMESPACE
class QComboBox;
class QDialogButtonBox;
class QLabel;
class QLineEdit;
class QPushButton;
class QTcpSocket;
class BonjourServiceBrowser;
class BonjourServiceResolver;
class QHostInfo;
QT_END_NAMESPACE

class Client : public QDialog
{
    Q_OBJECT

public:
    Client(QWidget *parent = 0);

private slots:
    void updateRecords(const QList<BonjourRecord> &list);
    void displayError(QAbstractSocket::SocketError socketError);
    void connectToServer(const QHostInfo &hostInfo, int);
    void enableResolveButton();
    void resolveService();

private:
    QLabel *statusLabel;
    QPushButton *resolveButton;
    QPushButton *quitButton;
    QDialogButtonBox *buttonBox;

    QTcpSocket *tcpSocket;
    quint16 blockSize;

    BonjourServiceBrowser *bonjourBrowser;
    BonjourServiceResolver *bonjourResolver;
    QTreeWidget *treeWidget;
};

#endif
