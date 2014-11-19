#include "uctrlapifacade.h"

UCtrlAPIFacade::UCtrlAPIFacade(QNetworkAccessManager* nam, UPlatformsModel* platforms, QObject *parent)
    : uCtrlApi(nam, platforms, parent)
{
}

// Helpers
void UCtrlAPIFacade::resolveIds(QString& platformId, QString& deviceId, QString& scenarioId, QString& taskId, const UCondition& condition)
{
    UTask* task = (UTask*)condition.parent()->parent();
    taskId = task->id();
    resolveIds(platformId, deviceId, scenarioId, *task);
}

void UCtrlAPIFacade::resolveIds(QString& platformId, QString& deviceId, QString& scenarioId, const UTask& task)
{
    UScenario* scenario = (UScenario*)task.parent()->parent();
    scenarioId = scenario->id();
    resolveIds(platformId, deviceId, *scenario);
}

void UCtrlAPIFacade::resolveIds(QString& platformId, QString& deviceId, const UScenario& scenario)
{
    UDevice* device = (UDevice*)scenario.parent()->parent();
    deviceId = device->id();
    resolveIds(platformId, *device);
}

void UCtrlAPIFacade::resolveIds(QString& platformId, const UDevice& device)
{
    UPlatform* platform = (UPlatform*)device.parent()->parent();
    platformId = platform->id();
}

// Facade
void UCtrlAPIFacade::postUser()
{
    uCtrlApi.postUser();
}

void UCtrlAPIFacade::getUserStream()
{
    uCtrlApi.getUserStream();
}

void UCtrlAPIFacade::getSystem()
{
    uCtrlApi.getSystem();
}

void UCtrlAPIFacade::getPlatforms()
{
    uCtrlApi.getPlatforms();
}

void UCtrlAPIFacade::postPlatform(const UPlatform& platform)
{
    uCtrlApi.postPlatform(platform.id());
}

void UCtrlAPIFacade::getPlatform(const UPlatform& platform)
{
    uCtrlApi.getPlatform(platform.id());
}

void UCtrlAPIFacade::putPlatform(const UPlatform& platform)
{
    uCtrlApi.putPlatform(platform.id());
}

void UCtrlAPIFacade::deletePlatform(const UPlatform& platform)
{
    uCtrlApi.deletePlatform(platform.id());
}

void UCtrlAPIFacade::getDevices(const UPlatform& platform)
{
    uCtrlApi.getDevices(platform.id());
}
void UCtrlAPIFacade::postDevice(const UDevice& device)
{
    QString platformId;
    resolveIds(platformId, device);
    uCtrlApi.postDevice(platformId, device.id());
}
void UCtrlAPIFacade::getDevice(const UDevice& device)
{
    QString platformId;
    resolveIds(platformId, device);
    uCtrlApi.getDevice(platformId, device.id());
}
void UCtrlAPIFacade::putDevice(const UDevice& device)
{
    QString platformId;
    resolveIds(platformId, device);
    uCtrlApi.putDevice(platformId, device.id());
}
void UCtrlAPIFacade::deleteDevice(const UDevice& device)
{
    QString platformId;
    resolveIds(platformId, device);
    uCtrlApi.deleteDevice(platformId, device.id());
}

void UCtrlAPIFacade::getScenarios(const UDevice& device)
{
    QString platformId;
    resolveIds(platformId, device);
    uCtrlApi.getScenarios(platformId, device.id());
}

void UCtrlAPIFacade::postScenario(const UScenario& scenario)
{
    QString platformId;
    QString deviceId;
    resolveIds(platformId, deviceId, scenario);
    uCtrlApi.postScenario(platformId, deviceId, scenario.id());
}
void UCtrlAPIFacade::getScenario(const UScenario& scenario)
{
    QString platformId;
    QString deviceId;
    resolveIds(platformId, deviceId, scenario);
    uCtrlApi.getScenario(platformId, deviceId, scenario.id());
}
void UCtrlAPIFacade::putScenario(const UScenario& scenario)
{
    QString platformId;
    QString deviceId;
    resolveIds(platformId, deviceId, scenario);
    uCtrlApi.putScenario(platformId, deviceId, scenario.id());
}
void UCtrlAPIFacade::deleteScenario(const UScenario& scenario)
{
    QString platformId;
    QString deviceId;
    resolveIds(platformId, deviceId, scenario);
    uCtrlApi.deleteScenario(platformId, deviceId, scenario.id());
}

void UCtrlAPIFacade::getTasks(const UScenario& scenario)
{
    QString platformId;
    QString deviceId;
    resolveIds(platformId, deviceId, scenario);
    uCtrlApi.getTasks(platformId, deviceId, scenario.id());
}

void UCtrlAPIFacade::postTask(const UTask& task)
{
    QString platformId;
    QString deviceId;
    QString scenarioId;
    resolveIds(platformId, deviceId, scenarioId, task);
    uCtrlApi.postTask(platformId, deviceId, scenarioId, task.id());
}

void UCtrlAPIFacade::getTask(const UTask& task)
{
    QString platformId;
    QString deviceId;
    QString scenarioId;
    resolveIds(platformId, deviceId, scenarioId, task);
    uCtrlApi.getTask(platformId, deviceId, scenarioId, task.id());
}

void UCtrlAPIFacade::putTask(const UTask& task)
{
    QString platformId;
    QString deviceId;
    QString scenarioId;
    resolveIds(platformId, deviceId, scenarioId, task);
    uCtrlApi.putTask(platformId, deviceId, scenarioId, task.id());
}

void UCtrlAPIFacade::deleteTask(const UTask& task)
{
    QString platformId;
    QString deviceId;
    QString scenarioId;
    resolveIds(platformId, deviceId, scenarioId, task);
    uCtrlApi.deleteTask(platformId, deviceId, scenarioId, task.id());
}

void UCtrlAPIFacade::getConditions(const UTask& task)
{
    QString platformId;
    QString deviceId;
    QString scenarioId;
    resolveIds(platformId, deviceId, scenarioId, task);
    uCtrlApi.getConditions(platformId, deviceId, scenarioId, task.id());
}

void UCtrlAPIFacade::postCondition(const UCondition& condition)
{
    QString platformId;
    QString deviceId;
    QString scenarioId;
    QString taskId;
    resolveIds(platformId, deviceId, scenarioId, taskId, condition);
    uCtrlApi.postCondition(platformId, deviceId, scenarioId, taskId, condition.id());
}

void UCtrlAPIFacade::getCondition(const UCondition& condition)
{
    QString platformId;
    QString deviceId;
    QString scenarioId;
    QString taskId;
    resolveIds(platformId, deviceId, scenarioId, taskId, condition);
    uCtrlApi.getCondition(platformId, deviceId, scenarioId, taskId, condition.id());
}

void UCtrlAPIFacade::putCondition(const UCondition& condition)
{
    QString platformId;
    QString deviceId;
    QString scenarioId;
    QString taskId;
    resolveIds(platformId, deviceId, scenarioId, taskId, condition);
    uCtrlApi.putCondition(platformId, deviceId, scenarioId, taskId, condition.id());
}

void UCtrlAPIFacade::deleteCondition(const UCondition& condition)
{
    QString platformId;
    QString deviceId;
    QString scenarioId;
    QString taskId;
    resolveIds(platformId, deviceId, scenarioId, taskId, condition);
    uCtrlApi.deleteCondition(platformId, deviceId, scenarioId, taskId, condition.id());
}
