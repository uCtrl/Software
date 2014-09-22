#ifndef UNINJABLOCKSAPI_H
#define UNINJABLOCKSAPI_H

#include <QObject>
#include <QtNetwork>

const QString NinjaBaseUrl = "https://api.ninja.is/rest/v0/";
const QString UserAccessToken = "107f6f460bed2dbb10f0a93b994deea7fe07dad5";

class UNinjaBlocksAPI : public QObject
{
    Q_OBJECT

public:
    explicit UNinjaBlocksAPI(QNetworkAccessManager* nam, QObject *parent = 0);

    //User
    Q_INVOKABLE void getUser();
    Q_INVOKABLE void getUserStream();
    Q_INVOKABLE void getUserPusherChannel();
    Q_INVOKABLE void putUserRealtime(int length);

    //Block
    Q_INVOKABLE void getBlocks();
    Q_INVOKABLE void getBlock(const QString& nodeId);
    Q_INVOKABLE void postBlock(const QString& nodeId);
    Q_INVOKABLE void getBlockActivate(const QString& nodeId);
    Q_INVOKABLE void deleteBlock(const QString& nodeId);

    //Devices
    Q_INVOKABLE void getDevices();
    Q_INVOKABLE void getDevice(const QString& guid);
    Q_INVOKABLE void putDevice(const QString& guid, const QString& da, const QString& shortName);
    Q_INVOKABLE void deleteDevice(const QString& guid);
    Q_INVOKABLE void getDeviceHeartbeat(const QString& guid);
    Q_INVOKABLE void getDeviceData(const QString& guid, const QString& from, const QString& to, const QString& interval, const QString& fn);
    Q_INVOKABLE void postDeviceCallback(const QString& guid, const QString& url);
    Q_INVOKABLE void getDeviceCallback(const QString& guid);
    Q_INVOKABLE void putDeviceCallback(const QString& guid, const QString& url);
    Q_INVOKABLE void deleteDeviceCallback(const QString& guid);
    Q_INVOKABLE void postSubdevice(const QString& guid, const QString& category, const QString& type, const QString& shortName, const QString& data, const QString& url);
    Q_INVOKABLE void putSubdevice(const QString& guid, const QString& subDeviceId, const QString& category, const QString& type, const QString& shortName, const QString& data, const QString& url);
    Q_INVOKABLE void deleteSubdevice(const QString& guid, const QString& subDeviceId);
    Q_INVOKABLE void getSubdeviceData(const QString& guid, const QString& subDeviceId, const QString& from, const QString& to, const QString& interval);

    // Rules
    Q_INVOKABLE void getRules();
    Q_INVOKABLE void getRule(const QString& ruleId);
    Q_INVOKABLE void postRule(const QString& shortName, const QString& preConditions, const QString& actions, const QString& timeout);
    Q_INVOKABLE void putRule(const QString& ruleId, const QString& shortName, const QString& preConditions, const QString& actions, const QString& timeout);
    Q_INVOKABLE void deleteRule(const QString& ruleId);
    Q_INVOKABLE void suspendRule(const QString& ruleId);
    Q_INVOKABLE void unsuspendRule(const QString& ruleId);

signals:
    void networkError(QNetworkReply::NetworkError err);

public slots:

private slots:
    // User
    void getUserReply();
    void getUserStreamReply();
    void getUserPusherChannelReply();
    void putUserRealtimeReply();

    // Block
   void getBlocksReply();
   void getBlockReply();
   void postBlockReply();
   void getBlockActivateReply();
   void deleteBlockReply();

   // Devices
   void getDevicesReply();
   void getDeviceReply();
   void putDeviceReply();
   void deleteDeviceReply();
   void getDeviceHeartbeatReply();
   void getDeviceDataReply();
   void postDeviceCallbackReply();
   void getDeviceCallbackReply();
   void putDeviceCallbackReply();
   void deleteDeviceCallbackReply();
   void postSubdeviceReply();
   void putSubdeviceReply();
   void deleteSubdeviceReply();
   void getSubdeviceDataReply();

   // Rules
   void getRulesReply();
   void getRuleReply();
   void postRuleReply();
   void putRuleReply();
   void deleteRuleReply();
   void suspendRuleReply();
   void unsuspendRuleReply();

private:
    QNetworkReply* getRequest(const QString& url);
    QNetworkReply* postRequest(const QString& url, const QByteArray& data);
    QNetworkReply* putRequest(const QString &urlString, const QByteArray& data);
    QNetworkReply* deleteRequest(const QString& url);

    QNetworkAccessManager* m_networkAccessManager;
};

#endif // UNINJABLOCKSAPI_H
