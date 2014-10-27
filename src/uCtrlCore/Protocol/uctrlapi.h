#ifndef UCTRLAPI_H
#define UCTRLAPI_H

#include <QObject>
#include <QtNetwork>
#include "Serialization/jsonserializer.h"
#include "Platform/uplatformsmodel.h"
#include "Device/udevicesmodel.h"
#include "Scenario/uscenariosmodel.h"
#include "Task/utasksmodel.h"
#include "Condition/uconditionsmodel.h"

const char* const PlatformId = "platformId";
const char* const DeviceId = "deviceId";
const char* const ScenarioId = "scenarioId";
const char* const TaskId = "taskId";
const char* const ConditionId = "conditionId";

class UCtrlAPI : public QObject
{
    Q_OBJECT

public:
    explicit UCtrlAPI(QNetworkAccessManager* nam, UPlatformsModel* platforms, QObject *parent = 0);

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

signals:
    void networkError(QNetworkReply::NetworkError errorString);
    void serverError(const QString& errorString);
    void modelError(const QString& errorString);

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

private:
    bool checkServerError(const QJsonObject& jsonObj);
    bool checkNetworkError(QNetworkReply* reply);
    bool checkModel(ListItem* item);
    QNetworkReply* getRequest(const QString& url);
    QNetworkReply* postRequest(const QString& url, JsonWritable* data);
    QNetworkReply* putRequest(const QString &urlString, JsonWritable* data);
    QNetworkReply* deleteRequest(const QString& url);

    UPlatformsModel* m_platforms;
    QString m_ninjaToken;
    QString m_serverBaseUrl;
    QString m_userToken;
    QNetworkAccessManager* m_networkAccessManager;
};

#endif // UCTRLAPI_H
