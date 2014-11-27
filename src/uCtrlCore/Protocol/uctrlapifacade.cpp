#include "uctrlapifacade.h"

UCtrlAPIFacade::UCtrlAPIFacade(QNetworkAccessManager* nam, UPlatformsModel* platforms, QObject *parent)
    : m_uCtrlApi(nam, platforms, parent)
    , m_uCtrlLocalApi(platforms, parent)
{
}

// Helpers
void UCtrlAPIFacade::resolveIds(QString& platformId, QString& deviceId, QString& scenarioId, QString& taskId, UCondition* condition)
{
    UTask* task = (UTask*)condition->parent()->parent();
    taskId = task->id();
    resolveIds(platformId, deviceId, scenarioId, task);
}

void UCtrlAPIFacade::resolveIds(QString& platformId, QString& deviceId, QString& scenarioId, UTask* task)
{
    UScenario* scenario = (UScenario*)task->parent()->parent();
    scenarioId = scenario->id();
    resolveIds(platformId, deviceId, scenario);
}

void UCtrlAPIFacade::resolveIds(QString& platformId, QString& deviceId, UScenario* scenario)
{
    UDevice* device = (UDevice*)scenario->parent()->parent();
    deviceId = device->id();
    resolveIds(platformId, device);
}

void UCtrlAPIFacade::resolveIds(QString& platformId, UDevice* device)
{
    UPlatform* platform = (UPlatform*)device->parent()->parent();
    platformId = platform->id();
}

// Facade
void UCtrlAPIFacade::postUser()
{
    m_uCtrlApi.postUser();
}

void UCtrlAPIFacade::getUserStream()
{
    m_uCtrlApi.getUserStream();
}

void UCtrlAPIFacade::getSystem()
{
    m_uCtrlApi.getSystem();
}

void UCtrlAPIFacade::getPlatforms()
{
    m_uCtrlApi.getPlatforms();
}

void UCtrlAPIFacade::postPlatform(UPlatform* platform)
{
    if (platform->isLocalPlatform())
        return;

    m_uCtrlApi.postPlatform(platform->id());
}

void UCtrlAPIFacade::getPlatform(UPlatform* platform)
{
    // Not working on uCtrl Hardware, platforms are broadcasted
    if (platform->isLocalPlatform())
        return;

    m_uCtrlApi.getPlatform(platform->id());
}

void UCtrlAPIFacade::putPlatform(UPlatform* platform)
{
    if (platform->isLocalPlatform())
        m_uCtrlLocalApi.savePlatform(platform);
    else
        m_uCtrlApi.putPlatform(platform->id());
}

void UCtrlAPIFacade::deletePlatform(UPlatform* platform)
{
    if (platform->isLocalPlatform()) // WHAT DO?
        return;
    else
        m_uCtrlApi.deletePlatform(platform->id());
}

void UCtrlAPIFacade::getDevices(UPlatform* platform)
{
    if (platform->isLocalPlatform())
        m_uCtrlLocalApi.getDevices(platform);
    else
        m_uCtrlApi.getDevices(platform->id());
}
void UCtrlAPIFacade::postDevice(UDevice* device)
{
    UPlatform* platform = (UPlatform*)device->parent()->parent();
    if (platform->isLocalPlatform())
        putDevice(device);
    else
    {
        QString platformId;
        resolveIds(platformId, device);
        m_uCtrlApi.postDevice(platformId, device->id());
    }
}
void UCtrlAPIFacade::getDevice(UDevice* device)
{
    UPlatform* platform = (UPlatform*)device->parent()->parent();
    if (platform->isLocalPlatform())
    {
        // TODO
        return;
    }
    else
    {
        QString platformId;
        resolveIds(platformId, device);
        m_uCtrlApi.getDevice(platformId, device->id());
    }
}
void UCtrlAPIFacade::putDevice(UDevice* device)
{
    UPlatform* platform = (UPlatform*)device->parent()->parent();
    if (platform->isLocalPlatform())
        m_uCtrlLocalApi.saveDevices(platform);
    else
    {
        QString platformId;
        resolveIds(platformId, device);
        m_uCtrlApi.putDevice(platformId, device->id());
    }
}
void UCtrlAPIFacade::deleteDevice(UDevice* device)
{
    UPlatform* platform = (UPlatform*)device->parent()->parent();
    if (platform->isLocalPlatform())
        putDevice(device);
    else
    {
        QString platformId;
        resolveIds(platformId, device);
        m_uCtrlApi.deleteDevice(platformId, device->id());
    }
}

void UCtrlAPIFacade::getDeviceAllStats(UDevice *device, QMap<QString, QVariant> params)
{
    UPlatform* platform = (UPlatform*)device->parent()->parent();
    if (platform->isLocalPlatform())
        return;

    QString platformId;
    resolveIds(platformId, device);
    m_uCtrlApi.getDeviceValues(platformId, device->id(), params);
    m_uCtrlApi.getDeviceMax(platformId, device->id(), params);
    m_uCtrlApi.getDeviceMin(platformId, device->id(), params);
    m_uCtrlApi.getDeviceMean(platformId, device->id(), params);
    m_uCtrlApi.getDeviceCount(platformId, device->id(), params);
}

void UCtrlAPIFacade::getDeviceValues(UDevice *device, QMap<QString, QVariant> params)
{
    UPlatform* platform = (UPlatform*)device->parent()->parent();
    if (platform->isLocalPlatform())
        return;

    QString platformId;
    resolveIds(platformId, device);
    m_uCtrlApi.getDeviceValues(platformId, device->id(), params);
}

void UCtrlAPIFacade::getDeviceMax(UDevice *device, QMap<QString, QVariant> params)
{
    UPlatform* platform = (UPlatform*)device->parent()->parent();
    if (platform->isLocalPlatform())
        return;

    QString platformId;
    resolveIds(platformId, device);
    m_uCtrlApi.getDeviceMax(platformId, device->id(), params);
}

void UCtrlAPIFacade::getDeviceMin(UDevice *device, QMap<QString, QVariant> params)
{
    UPlatform* platform = (UPlatform*)device->parent()->parent();
    if (platform->isLocalPlatform())
        return;

    QString platformId;
    resolveIds(platformId, device);
    m_uCtrlApi.getDeviceMin(platformId, device->id(), params);
}

void UCtrlAPIFacade::getDeviceMean(UDevice *device, QMap<QString, QVariant> params)
{
    UPlatform* platform = (UPlatform*)device->parent()->parent();
    if (platform->isLocalPlatform())
        return;

    QString platformId;
    resolveIds(platformId, device);
    m_uCtrlApi.getDeviceMean(platformId, device->id(), params);
}

void UCtrlAPIFacade::getDeviceCount(UDevice *device, QMap<QString, QVariant> params)
{
    UPlatform* platform = (UPlatform*)device->parent()->parent();
    if (platform->isLocalPlatform())
        return;

    QString platformId;
    resolveIds(platformId, device);
    m_uCtrlApi.getDeviceCount(platformId, device->id(), params);
}

void UCtrlAPIFacade::getDeviceHistory(UDevice *device, QMap<QString, QVariant> params)
{
    UPlatform* platform = (UPlatform*)device->parent()->parent();
    if (platform->isLocalPlatform())
        return;

    QString platformId;
    resolveIds(platformId, device);
    m_uCtrlApi.getDeviceHistory(platformId, device->id(), params);
}

void UCtrlAPIFacade::getScenarios(UDevice* device)
{
    UPlatform* platform = (UPlatform*)device->parent()->parent();
    if (platform->isLocalPlatform())
        m_uCtrlLocalApi.getScenarios(device);
    else
    {
        QString platformId;
        resolveIds(platformId, device);
        m_uCtrlApi.getScenarios(platformId, device->id());
    }
}

void UCtrlAPIFacade::postScenario(UScenario* scenario)
{
    UPlatform* platform = (UPlatform*)scenario->parent()->parent()->parent()->parent();
    if (platform->isLocalPlatform())
        putScenario(scenario);
    else
    {
        QString platformId;
        QString deviceId;
        resolveIds(platformId, deviceId, scenario);
        m_uCtrlApi.postScenario(platformId, deviceId, scenario->id());
    }
}

void UCtrlAPIFacade::getScenario(UScenario* scenario)
{
    UPlatform* platform = (UPlatform*)scenario->parent()->parent()->parent()->parent();
    if (platform->isLocalPlatform())
        return;

    QString platformId;
    QString deviceId;
    resolveIds(platformId, deviceId, scenario);
    m_uCtrlApi.getScenario(platformId, deviceId, scenario->id());
}
void UCtrlAPIFacade::putScenario(UScenario* scenario)
{
    UDevice* device = (UDevice*)scenario->parent()->parent();
    UPlatform* platform = (UPlatform*)device;
    if (platform->isLocalPlatform())
        m_uCtrlLocalApi.saveScenarios(device);
    else
    {
        QString platformId;
        QString deviceId;
        resolveIds(platformId, deviceId, scenario);
        m_uCtrlApi.putScenario(platformId, deviceId, scenario->id());
    }
}
void UCtrlAPIFacade::deleteScenario(UScenario* scenario)
{
    UPlatform* platform = (UPlatform*)scenario->parent()->parent()->parent()->parent();
    if (platform->isLocalPlatform())
        putScenario(scenario);
    else
    {
        QString platformId;
        QString deviceId;
        resolveIds(platformId, deviceId, scenario);
        m_uCtrlApi.deleteScenario(platformId, deviceId, scenario->id());
    }
}

void UCtrlAPIFacade::getTasks(UScenario* scenario)
{
    UPlatform* platform = (UPlatform*)scenario->parent()->parent()->parent()->parent();
    if (platform->isLocalPlatform())
        m_uCtrlLocalApi.getTasks(scenario);
    else
    {
        QString platformId;
        QString deviceId;
        resolveIds(platformId, deviceId, scenario);
        m_uCtrlApi.getTasks(platformId, deviceId, scenario->id());
    }
}

void UCtrlAPIFacade::postTask(UTask* task)
{
    UPlatform* platform = (UPlatform*)task->parent()->parent()->parent()->parent()->parent()->parent();
    if (platform->isLocalPlatform())
        putTask(task);
    else
    {
        QString platformId;
        QString deviceId;
        QString scenarioId;
        resolveIds(platformId, deviceId, scenarioId, task);
        m_uCtrlApi.postTask(platformId, deviceId, scenarioId, task->id());
    }
}

void UCtrlAPIFacade::getTask(UTask* task)
{
    UPlatform* platform = (UPlatform*)task->parent()->parent()->parent()->parent()->parent()->parent();
    if (platform->isLocalPlatform())
        return;

    QString platformId;
    QString deviceId;
    QString scenarioId;
    resolveIds(platformId, deviceId, scenarioId, task);
    m_uCtrlApi.getTask(platformId, deviceId, scenarioId, task->id());
}

void UCtrlAPIFacade::putTask(UTask* task)
{
    UPlatform* platform = (UPlatform*)task->parent()->parent()->parent()->parent()->parent()->parent();
    UScenario* scenario = (UScenario*)task->parent()->parent();
    if (platform->isLocalPlatform())
        m_uCtrlLocalApi.saveTasks(scenario);
    else
    {
        QString platformId;
        QString deviceId;
        QString scenarioId;
        resolveIds(platformId, deviceId, scenarioId, task);
        m_uCtrlApi.putTask(platformId, deviceId, scenarioId, task->id());
    }
}

void UCtrlAPIFacade::deleteTask(UTask* task)
{
    UPlatform* platform = (UPlatform*)task->parent()->parent()->parent()->parent()->parent()->parent();
    if (platform->isLocalPlatform())
        putTask(task);
    else
    {
        QString platformId;
        QString deviceId;
        QString scenarioId;
        resolveIds(platformId, deviceId, scenarioId, task);
        m_uCtrlApi.deleteTask(platformId, deviceId, scenarioId, task->id());
    }
}

void UCtrlAPIFacade::getConditions(UTask* task)
{
    UPlatform* platform = (UPlatform*)task->parent()->parent()->parent()->parent()->parent()->parent();
    if (platform->isLocalPlatform())
        m_uCtrlLocalApi.getConditions(task);
    else
    {
        QString platformId;
        QString deviceId;
        QString scenarioId;
        resolveIds(platformId, deviceId, scenarioId, task);
        m_uCtrlApi.getConditions(platformId, deviceId, scenarioId, task->id());
    }
}

void UCtrlAPIFacade::postCondition(UCondition* condition)
{
    UPlatform* platform = (UPlatform*)condition->parent()->parent()->parent()->parent()->parent()->parent()->parent()->parent();
    if (platform->isLocalPlatform())
        putCondition(condition);
    else
    {
        QString platformId;
        QString deviceId;
        QString scenarioId;
        QString taskId;
        resolveIds(platformId, deviceId, scenarioId, taskId, condition);
        m_uCtrlApi.postCondition(platformId, deviceId, scenarioId, taskId, condition->id());
    }
}

void UCtrlAPIFacade::getCondition(UCondition* condition)
{
    UPlatform* platform = (UPlatform*)condition->parent()->parent()->parent()->parent()->parent()->parent()->parent()->parent();
    if (platform->isLocalPlatform())
        return;

    QString platformId;
    QString deviceId;
    QString scenarioId;
    QString taskId;
    resolveIds(platformId, deviceId, scenarioId, taskId, condition);
    m_uCtrlApi.getCondition(platformId, deviceId, scenarioId, taskId, condition->id());
}

void UCtrlAPIFacade::putCondition(UCondition* condition)
{
    UPlatform* platform = (UPlatform*)condition->parent()->parent()->parent()->parent()->parent()->parent()->parent()->parent();
    UTask* task = (UTask*)condition->parent()->parent();
    if (platform->isLocalPlatform())
        m_uCtrlLocalApi.saveConditions(task);
    else
    {
        QString platformId;
        QString deviceId;
        QString scenarioId;
        QString taskId;
        resolveIds(platformId, deviceId, scenarioId, taskId, condition);
        m_uCtrlApi.putCondition(platformId, deviceId, scenarioId, taskId, condition->id());
    }
}

void UCtrlAPIFacade::deleteCondition(UCondition* condition)
{
    UPlatform* platform = (UPlatform*)condition->parent()->parent()->parent()->parent()->parent()->parent()->parent()->parent();
    if (platform->isLocalPlatform())
        putCondition(condition);
    else
    {
        QString platformId;
        QString deviceId;
        QString scenarioId;
        QString taskId;
        resolveIds(platformId, deviceId, scenarioId, taskId, condition);
        m_uCtrlApi.deleteCondition(platformId, deviceId, scenarioId, taskId, condition->id());
    }
}

void UCtrlAPIFacade::getRecommendations()
{
    m_uCtrlApi.getRecommendations();
}

void UCtrlAPIFacade::acceptRecommendation(const QString &recommendationId, bool accepted)
{
    m_uCtrlApi.acceptRecommendation(recommendationId, accepted);
}

