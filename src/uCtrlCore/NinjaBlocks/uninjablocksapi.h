#ifndef UNINJABLOCKSAPI_H
#define UNINJABLOCKSAPI_H

#include <QObject>
#include <QtNetwork>

class UNinjaBlocksAPI : public QObject
{
    Q_OBJECT
public:
    explicit UNinjaBlocksAPI(QNetworkAccessManager* nam, QObject *parent = 0);

signals:

public slots:

private:
    QNetworkAccessManager* m_networkAccessManager;

};

#endif // UNINJABLOCKSAPI_H
