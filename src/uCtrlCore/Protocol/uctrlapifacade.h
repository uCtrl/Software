#ifndef UCTRLAPIFACADE_H
#define UCTRLAPIFACADE_H

#include "uctrlapi.h"
#include "uctrllocalapi.h"
#include "Device/udevicesmodel.h"

class UCtrlAPIFacade : public QObject
{
    Q_OBJECT

public:
    explicit UCtrlAPIFacade(QNetworkAccessManager* nam, UPlatformsModel* platforms, QObject *parent = 0);

    //User
    Q_INVOKABLE void postUser();
    Q_INVOKABLE void getUserStream();

    //Sytem
    Q_INVOKABLE void getSystem();

    //Platforms
    Q_INVOKABLE void getPlatforms();
    Q_INVOKABLE void postPlatform(UPlatform* platform);
    Q_INVOKABLE void getPlatform(UPlatform* platform);
    Q_INVOKABLE void putPlatform(UPlatform* platform);
    Q_INVOKABLE void deletePlatform(UPlatform* platform);

    //Devices
    Q_INVOKABLE void getDevices(UPlatform* platform);
    Q_INVOKABLE void postDevice(UDevice* device);
    Q_INVOKABLE void getDevice(UDevice* device);
    Q_INVOKABLE void putDevice(UDevice* device);
    Q_INVOKABLE void deleteDevice(UDevice* device);

    Q_INVOKABLE void getDeviceAllStats(UDevice* device, QMap<QString, QVariant> params = QMap<QString, QVariant>());
    Q_INVOKABLE void getDeviceValues(UDevice* device, QMap<QString, QVariant> params = QMap<QString, QVariant>());
    Q_INVOKABLE void getDeviceMax(UDevice* device, QMap<QString, QVariant> params = QMap<QString, QVariant>());
    Q_INVOKABLE void getDeviceMin(UDevice* device, QMap<QString, QVariant> params = QMap<QString, QVariant>());
    Q_INVOKABLE void getDeviceMean(UDevice* device, QMap<QString, QVariant> params = QMap<QString, QVariant>());
    Q_INVOKABLE void getDeviceCount(UDevice* device, QMap<QString, QVariant> params = QMap<QString, QVariant>());

    Q_INVOKABLE void getDeviceHistory(UDevice* device, QMap<QString, QVariant> params = QMap<QString, QVariant>());

    // Scenarios
    Q_INVOKABLE void getScenarios(UDevice* device);
    Q_INVOKABLE void postScenario(UScenario* scenario);
    Q_INVOKABLE void getScenario(UScenario* scenario);
    Q_INVOKABLE void putScenario(UScenario* scenario);
    Q_INVOKABLE void deleteScenario(UScenario* scenario);

    // Tasks
    Q_INVOKABLE void getTasks(UScenario* scenario);
    Q_INVOKABLE void postTask(UTask* task);
    Q_INVOKABLE void getTask(UTask* task);
    Q_INVOKABLE void putTask(UTask* task);
    Q_INVOKABLE void deleteTask(UTask* task);

    // Conditions
    Q_INVOKABLE void getConditions(UTask* task);
    Q_INVOKABLE void postCondition(UCondition* condition);
    Q_INVOKABLE void getCondition(UCondition* condition);
    Q_INVOKABLE void putCondition(UCondition* condition);
    Q_INVOKABLE void deleteCondition(UCondition* condition);

    // Recommendations
    Q_INVOKABLE void getRecommendations();
    Q_INVOKABLE void acceptRecommendation(const QString& recommendationId, bool accepted);

    Q_INVOKABLE UCtrlAPI* getAPI() { return &m_uCtrlApi; }

    UPlatformsModel* getPlatformsModel() { return m_uCtrlApi.getPlatformsModel(); }

    // Global Statistics
    Q_INVOKABLE void getOverallMax(QMap<QString, QVariant> params);

private:
    UCtrlAPI m_uCtrlApi;
    UCtrlLocalApi m_uCtrlLocalApi;

    void resolveIds(QString& platformId, QString& deviceId, QString& scenarioId, QString& taskId, UCondition* condition);
    void resolveIds(QString& platformId, QString& deviceId, QString& scenarioId, UTask* task);
    void resolveIds(QString& platformId, QString& deviceId, UScenario* scenario);
    void resolveIds(QString& platformId, UDevice* device);

};

#endif // UCTRLAPIFACADE_H
