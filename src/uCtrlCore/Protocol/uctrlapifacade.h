#ifndef UCTRLAPIFACADE_H
#define UCTRLAPIFACADE_H

#include "uctrlapi.h"

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
    Q_INVOKABLE void postPlatform(const UPlatform& platform);
    Q_INVOKABLE void getPlatform(const UPlatform& platform);
    Q_INVOKABLE void putPlatform(const UPlatform& platform);
    Q_INVOKABLE void deletePlatform(const UPlatform& platform);

    //Devices
    Q_INVOKABLE void getDevices(const UPlatform& platform);
    Q_INVOKABLE void postDevice(const UDevice& device);
    Q_INVOKABLE void getDevice(const UDevice& device);
    Q_INVOKABLE void putDevice(const UDevice& device);
    Q_INVOKABLE void deleteDevice(const UDevice& device);

    // Scenarios
    Q_INVOKABLE void getScenarios(const UDevice& device);
    Q_INVOKABLE void postScenario(const UScenario& scenario);
    Q_INVOKABLE void getScenario(const UScenario& scenario);
    Q_INVOKABLE void putScenario(const UScenario& scenario);
    Q_INVOKABLE void deleteScenario(const UScenario& scenario);

    // Tasks
    Q_INVOKABLE void getTasks(const UScenario& scenario);
    Q_INVOKABLE void postTask(const UTask& task);
    Q_INVOKABLE void getTask(const UTask& task);
    Q_INVOKABLE void putTask(const UTask& task);
    Q_INVOKABLE void deleteTask(const UTask& task);

    // Conditions
    Q_INVOKABLE void getConditions(const UTask& task);
    Q_INVOKABLE void postCondition(const UCondition& condition);
    Q_INVOKABLE void getCondition(const UCondition& condition);
    Q_INVOKABLE void putCondition(const UCondition& condition);
    Q_INVOKABLE void deleteCondition(const UCondition& condition);

    Q_INVOKABLE UCtrlAPI* getAPI() { return &m_uCtrlApi; }

private:
    UCtrlAPI m_uCtrlApi;

    void resolveIds(QString& platformId, QString& deviceId, QString& scenarioId, QString& taskId, const UCondition& condition);
    void resolveIds(QString& platformId, QString& deviceId, QString& scenarioId, const UTask& task);
    void resolveIds(QString& platformId, QString& deviceId, const UScenario& scenario);
    void resolveIds(QString& platformId, const UDevice& device);

};

#endif // UCTRLAPIFACADE_H
