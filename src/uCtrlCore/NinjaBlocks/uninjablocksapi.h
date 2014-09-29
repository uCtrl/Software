#ifndef UNINJABLOCKSAPI_H
#define UNINJABLOCKSAPI_H

#include <QObject>
#include <QtNetwork>

const QString NinjaBaseUrl = "http://localhost:3000/";
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

    //Platforms
    Q_INVOKABLE void getPlatforms();
    Q_INVOKABLE void postPlatforms(const QString& nodeId);

    Q_INVOKABLE void getPlatform(const QString& nodeId);
    Q_INVOKABLE void deletePlatform(const QString& nodeId);

    //Devices
    Q_INVOKABLE void getDevices(const QString& nodeId);

    Q_INVOKABLE void getDevice(const QString& nodeId, const QString& guid);
    Q_INVOKABLE void putDevice(const QString& nodeId, const QString& guid, const QString& da, const QString& shortName);
    Q_INVOKABLE void deleteDevice(const QString& nodeId, const QString& guid);

/*    Q_INVOKABLE void getDeviceHeartbeat(const QString& nodeId, const QString& guid);
    Q_INVOKABLE void getDeviceData(const QString& nodeId, const QString& guid, const QString& from, const QString& to, const QString& interval, const QString& fn);
    Q_INVOKABLE void getDeviceCallback(const QString& guid);
    Q_INVOKABLE void putDeviceCallback(const QString& guid, const QString& url);
    Q_INVOKABLE void postDeviceCallback(const QString& guid, const QString& url);
    Q_INVOKABLE void deleteDeviceCallback(const QString& guid);

    Q_INVOKABLE void postSubdevice(const QString& guid, const QString& category, const QString& type, const QString& shortName, const QString& data, const QString& url);
    Q_INVOKABLE void putSubdevice(const QString& guid, const QString& subDeviceId, const QString& category, const QString& type, const QString& shortName, const QString& data, const QString& url);
    Q_INVOKABLE void deleteSubdevice(const QString& guid, const QString& subDeviceId);

    Q_INVOKABLE void getSubdeviceData(const QString& guid, const QString& subDeviceId, const QString& from, const QString& to, const QString& interval);
*/


    // Scenarii
    Q_INVOKABLE void getScenarios(const QString& nodeId, const QString& guid);
    Q_INVOKABLE void postScenarios(const QString& nodeId, const QString& guid);

    Q_INVOKABLE void getScenario(const QString& nodeId, const QString& guid, const QString& scenarioId);
    Q_INVOKABLE void putScenario(const QString& nodeId, const QString& guid, const QString& scenarioId);
    Q_INVOKABLE void deleteScenario(const QString& nodeId, const QString& guid, const QString& scenarioId);



    // Tasks
    Q_INVOKABLE void getTasks(const QString& nodeId, const QString& guid, const QString& scenarioId);
    Q_INVOKABLE void postTask(const QString& nodeId, const QString& guid, const QString& scenarioId, const QString& shortName, const QString& preConditions, const QString& actions, const QString& timeout);

    Q_INVOKABLE void getTask(const QString& nodeId, const QString& guid, const QString& scenarioId, const QString& taskId);
    Q_INVOKABLE void putTask(const QString& nodeId, const QString& guid, const QString& scenarioId, const QString& taskId, const QString& shortName, const QString& preConditions, const QString& actions, const QString& timeout);
    Q_INVOKABLE void deleteTask(const QString& nodeId, const QString& guid, const QString& scenarioId, const QString& taskId);

    /*   Q_INVOKABLE void suspendRule(const QString& ruleId);
    Q_INVOKABLE void unsuspendRule(const QString& ruleId);
*/
signals:
    void networkError(QNetworkReply::NetworkError err);

public slots:

private slots:
    // User
    void getUserReply();
    void getUserStreamReply();
    void getUserPusherChannelReply();
    void putUserRealtimeReply();

    // Platforms
   void getPlatformsReply();
   void postPlatformsReply();

   void getPlatformReply();
   void deletePlatformReply();


   // Devices
   void getDevicesReply();
   void getDeviceReply();
   void putDeviceReply();
   void deleteDeviceReply();
   /*
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
   */



   // Scenario
   void getScenariosReply();
   void postScenariosReply();

   void getScenarioReply();
   void putScenarioReply();
   void deleteScenarioReply();


   // Tasks
   void getTasksReply();
   void postTasksReply();

   void getTaskReply();
   void putTaskReply();
   void deleteTaskReply();



private:
    QNetworkReply* getRequest(const QString& url);
    QNetworkReply* postRequest(const QString& url, const QByteArray& data);
    QNetworkReply* putRequest(const QString &urlString, const QByteArray& data);
    QNetworkReply* deleteRequest(const QString& url);

    QNetworkAccessManager* m_networkAccessManager;
};

#endif // UNINJABLOCKSAPI_H
