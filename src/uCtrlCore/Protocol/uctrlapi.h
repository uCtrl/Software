#ifndef UCTRLAPI_H
#define UCTRLAPI_H

#include <QObject>
#include <QtNetwork>
#include <QtWebSockets/QWebSocket>
#include "Serialization/jsonserializer.h"
#include "Platform/uplatformsmodel.h"
#include "Device/udevicesmodel.h"
#include "Scenario/uscenariosmodel.h"
#include "Task/utasksmodel.h"
#include "Condition/uconditionsmodel.h"
#include "Recommendations/recommendationsModel.h"

const char* const PlatformId = "platformId";
const char* const DeviceId = "deviceId";
const char* const ScenarioId = "scenarioId";
const char* const TaskId = "taskId";
const char* const ConditionId = "conditionId";
const char* const ScenarioPtr = "scenarioPtr";
const char* const DevicePtr = "devicePtr";
const char* const TaskPtr = "taskPtr";
const char* const ConditionPtr = "conditionPtr";
const char* const DeviceType = "deviceType";

class UCtrlAPI : public QObject
{
    Q_OBJECT

public:
    explicit UCtrlAPI(QNetworkAccessManager* nam, UPlatformsModel* platforms, QObject *parent = 0);

    Q_PROPERTY(QString ninjaToken READ ninjaToken WRITE ninjaToken NOTIFY ninjaTokenChanged)
    Q_PROPERTY(QString serverBaseUrl READ serverBaseUrl WRITE serverBaseUrl NOTIFY serverBaseURLChanged)

    //User
    Q_INVOKABLE void postUser();
    Q_INVOKABLE void getUserStream();

    //Sytem
    Q_INVOKABLE void getSystem();

    //Platforms
    Q_INVOKABLE void getPlatforms();
    Q_INVOKABLE void postPlatform(const QString& platformId);
    Q_INVOKABLE void getPlatform(const QString& platformId);
    Q_INVOKABLE void putPlatform(const QString& platformId);
    Q_INVOKABLE void deletePlatform(const QString& platformId);

    //Devices
    Q_INVOKABLE void getDevices(const QString& platformId);
    Q_INVOKABLE void postDevice(const QString& platformId, const QString& deviceId);
    Q_INVOKABLE void getDevice(const QString& platformId, const QString& deviceId);
    Q_INVOKABLE void putDevice(const QString& platformId, const QString& deviceId);
    Q_INVOKABLE void deleteDevice(const QString& platformId, const QString& deviceId);

    Q_INVOKABLE void getDeviceMin(const QString& platformId, const QString& deviceId, QMap<QString, QVariant> params);
    Q_INVOKABLE void getDeviceMax(const QString& platformId, const QString& deviceId, QMap<QString, QVariant> params);
    Q_INVOKABLE void getDeviceMean(const QString& platformId, const QString& deviceId, QMap<QString, QVariant> params);
    Q_INVOKABLE void getDeviceCount(const QString& platformId, const QString& deviceId, QMap<QString, QVariant> params);
    Q_INVOKABLE void getDeviceValues(const QString& platformId, const QString& deviceId, QMap<QString, QVariant> params);
    Q_INVOKABLE void getDeviceHistory(const QString& platformId, const QString& deviceId, QMap<QString, QVariant> params);

    // Scenarios
    Q_INVOKABLE void getScenarios(const QString& platformId, const QString& deviceId);
    Q_INVOKABLE void postScenario(const QString& platformId, const QString& deviceId, const QString& scenarioId);
    Q_INVOKABLE void getScenario(const QString& platformId, const QString& deviceId, const QString& scenarioId);
    Q_INVOKABLE void putScenario(const QString& platformId, const QString& deviceId, const QString& scenarioId);
    Q_INVOKABLE void deleteScenario(const QString& platformId, const QString& deviceId, const QString& scenarioId);

    // Tasks
    Q_INVOKABLE void getTasks(const QString& platformId, const QString& deviceId, const QString& scenarioId);
    Q_INVOKABLE void postTask(const QString& platformId, const QString& deviceId, const QString& scenarioId, const QString& taskId);
    Q_INVOKABLE void getTask(const QString& platformId, const QString& deviceId, const QString& scenarioId, const QString& taskId);
    Q_INVOKABLE void putTask(const QString& platformId, const QString& deviceId, const QString& scenarioId, const QString& taskId);
    Q_INVOKABLE void deleteTask(const QString& platformId, const QString& deviceId, const QString& scenarioId, const QString& taskId);

    // Conditions
    Q_INVOKABLE void getConditions(const QString& platformId, const QString& deviceId, const QString& scenarioId, const QString& taskId);
    Q_INVOKABLE void postCondition(const QString& platformId, const QString& deviceId, const QString& scenarioId, const QString& taskId, const QString& conditionId);
    Q_INVOKABLE void getCondition(const QString& platformId, const QString& deviceId, const QString& scenarioId, const QString& taskId, const QString& conditionId);
    Q_INVOKABLE void putCondition(const QString& platformId, const QString& deviceId, const QString& scenarioId, const QString& taskId, const QString& conditionId);
    Q_INVOKABLE void deleteCondition(const QString& platformId, const QString& deviceId, const QString& scenarioId, const QString& taskId, const QString& conditionId);

    // Settings
    void ninjaToken(const QString& ninjaToken);
    const QString& ninjaToken();
    void serverBaseUrl(const QString& serverBaseUrl);
    const QString& serverBaseUrl();
    Q_INVOKABLE void synchronize();

    // Recommendations
    Q_INVOKABLE void getRecommendations();
    Q_INVOKABLE void acceptRecommendation(const QString& recommendationId, bool accpeted);

    // Platform models
    UPlatformsModel* getPlatformsModel() { return m_platforms; }

    // Overall statistics
    Q_INVOKABLE void getOverallTemperature(QMap<QString, QVariant> params);
    Q_INVOKABLE void getOverallHumidity(QMap<QString, QVariant> params);

signals:
    void networkError(const QString& errorString);
    void serverError(const QString& errorString);
    void modelError(const QString& errorString);

    // Settings
    void ninjaTokenChanged(const QString& ninjaToken);
    void serverBaseURLChanged(const QString& serverBaseUrl);

private slots:
    //User
    void postUserReply();

    //System
    void getSystemReply();

    //Platforms
    void getPlatformsReply();
    void postPlatformReply();
    void getPlatformReply();
    void putPlatformReply();
    void deletePlatformReply();

    //Devices
    void getDevicesReply();
    void postDeviceReply();
    void getDeviceReply();
    void putDeviceReply();
    void deleteDeviceReply();

    void getDeviceValuesReply();
    void getDeviceMinReply();
    void getDeviceMaxReply();
    void getDeviceMeanReply();
    void getDeviceCountReply();
    void getDeviceHistoryReply();

    // Scenarios
    void getScenariosReply();
    void postScenarioReply();
    void getScenarioReply();
    void putScenarioReply();
    void deleteScenarioReply();

    // Tasks
    void getTasksReply();
    void postTaskReply();
    void getTaskReply();
    void putTaskReply();
    void deleteTaskReply();

    // Conditions
    void getConditionsReply();
    void postConditionReply();
    void getConditionReply();
    void putConditionReply();
    void deleteConditionReply();

    // Websocket
    void onConnected();
    void onError(QAbstractSocket::SocketError error);
    void onMessageReceived(const QString& message);
    void onClosed();

    // Recommendations
    void getRecommendationsReply();
    void acceptRecommendationReply();

    // Global Statistics
    void getOverallTemperatureReply();
    void getOverallHumidityReply();

private:
    bool checkServerError(const QJsonObject& jsonObj);
    bool checkNetworkError(QNetworkReply* reply);
    bool checkModel(ListItem* item);
    QNetworkReply* getRequest(const QString& url, QMap<QString, QVariant> params = QMap<QString, QVariant>());
    QNetworkReply* postRequest(const QString& url, JsonWritable* data);
    QNetworkReply* putRequest(const QString &urlString, JsonWritable* data);
    QNetworkReply* deleteRequest(const QString& url);

    UPlatformsModel* m_platforms;
    QString m_ninjaToken;
    QString m_serverBaseUrl;
    QString m_userToken;
    QNetworkAccessManager* m_networkAccessManager;
    QWebSocket m_webSocket;
};

#endif // UCTRLAPI_H
