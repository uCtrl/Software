#include "uvoicecontrolapi.h"
#include "uvoicecontrolresponse.h"
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QUdpSocket>

UVoiceControlAPI::UVoiceControlAPI(QObject *parent) :
    QObject(parent)
{
    manager = new QNetworkAccessManager(this);
    connect(manager, SIGNAL(finished(QNetworkReply*)),
            this, SLOT(replyFinished(QNetworkReply*)));
}

void UVoiceControlAPI::sendVoiceControlFile(QString voiceFilePath)
{
    //testLimitlessLED();
    //return;

    QNetworkRequest request;
    request.setUrl(QUrl("https://api.wit.ai/speech"));
    request.setRawHeader("Authorization", "Bearer AJKFKPXCCXDD6CPEXASZMJSLCOZSUQ3Z");
    request.setRawHeader("Content-Type", "audio/wav");

    //voiceFilePath = "C:/Users/Frank/Desktop/c29decaada78f883c58fec7d46bb04a7.wav";
    voiceFile = new QFile(voiceFilePath);
    if (!voiceFile->open(QIODevice::ReadOnly))
        return;

    QNetworkReply* reply = manager->post(request, voiceFile);

    voiceFile->setParent(reply);
}

void UVoiceControlAPI::analyseIntent()
{
    QJsonDocument jsonResponse = QJsonDocument::fromJson(m_voiceControlIntent.toUtf8());
    QJsonObject jsonObj = jsonResponse.object();
    UVoiceControlResponse voiceControlResponse(jsonObj);

    //if (true)
    //    testLimitlessLED();

    // TEST CODE
    if (voiceControlResponse.getIntent() == QString("turn_onoff_all_lights"))
    {
        QJsonObject entities = voiceControlResponse.getEntities();
        QJsonValue onoffValue = entities["on_off"];
        QJsonArray onOffArray = onoffValue.toArray();
        QJsonObject firstObject = onOffArray.first().toObject();
        QString onoffString = firstObject["value"].toString();
        //qDebug() << onoffString;
    }
    else if (voiceControlResponse.getIntent() == QString("set_ninja_eyes_color"))
    {
        QJsonObject entities = voiceControlResponse.getEntities();
        QJsonValue colorValue = entities["uctrl_color"];
        QJsonArray colorArray = colorValue.toArray();
        QJsonObject firstObject = colorArray.first().toObject();
        QString colorString = firstObject["value"].toString();

        QNetworkRequest request;
        request.setUrl(QUrl("https://api.ninja.is/rest/v0/device/1014BBBK6089_0_0_1007?user_access_token=107f6f460bed2dbb10f0a93b994deea7fe07dad5"));
        request.setRawHeader("Content-Type", "application/json");

        QString dataStr = "{ \"DA\" : ";
        if (colorString == QString("red"))
        {
            dataStr.append("\"FF0000\" }");
        }
        else if (colorString == QString("green"))
        {
            dataStr.append("\"00FF00\" }");
        }
        else if (colorString == QString("blue"))
        {
            dataStr.append("\"0000FF\" }");
        }
        else if (colorString == QString("white"))
        {
            dataStr.append("\"FFFFFF\" }");
        }
        else
            return;

        QByteArray data = dataStr.toUtf8();
        QNetworkReply* reply = manager->put(request, data);
    }
    return;
}

void  UVoiceControlAPI::replyFinished(QNetworkReply* reply)
{
    // Reading attributes of the reply
    QVariant statusCodeV =
    reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);

    if (statusCodeV.toInt() == 200)
    {
        setVoiceControlIntent(QString(reply->readAll()));
    }
    // Some http error or redirect
    else
    {
        QString error = reply->errorString();
    }

    if (voiceFile)
    {
        voiceFile->close();
        voiceFile = NULL;
    }
    delete reply;
}

void UVoiceControlAPI::testLimitlessLED()
{
    QUdpSocket* clientSocket = new QUdpSocket(this);
    //m_oClientSocket ->connect(m_oClientSocket , SIGNAL(readyRead()), this, SLOT(__onClientRecv()));

    //QString sSendMsg = ui->txtClientSend->text();
    //m_oClientSocket->writeDatagram(sSendMsg.toUtf8(), QHostAddress::LocalHost, sPort.toInt());
    //QUdpSocket socket;

    QByteArray b = QByteArray("Link_Wi-Fi");
    long dataSentSize = clientSocket->writeDatagram(b, QHostAddress("255.255.255.255"), 48899);

    while (!clientSocket->hasPendingDatagrams());

    char* data;
    clientSocket->readDatagram(data, 1000);
    QString theData(data);
    return;
    /*
    udpAdmin.Client.SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.ReceiveTimeout, 1000);
    while (iFoundWifiBridges < 1000) {
        receiveBytes = udpAdmin.Receive(listenEP);
        //wait here until a UDP packet has been received.

        sResponse = UTF8.GetString(receiveBytes);  //convert udp datagram bytes into a string.
        static System.Text.RegularExpressions.Regex expression = new System.Text.RegularExpressions.Regex("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]),([A-F]|[0-9]){12},.*$");
        IsValidWifiBridgeResponse = expression.IsMatch(System.text);
       if (IsValidWifiBridgeResponse) {

       }
    }

      //Catch TimeOut Exception here, no more LimitlessLED Bridge devices responded within 1000ms.

    }*/
}
