#ifndef UCTRLLOCALAPI_H
#define UCTRLLOCALAPI_H

#include <QObject>
#include <QtNetwork>
#include "../Platform/uplatformsmodel.h"
#include <QMap>

class UCtrlLocalApi : public QObject
{
    Q_OBJECT

    enum class UEMessageType: int {
        GetPlatformRequest = 1,
        GetPlatformResponse = 2,
        GetDevicesRequest = 3,
        GetDevicesResponse = 4,
        GetScenariosRequest = 5,
        GetScenariosResponse = 6,
        GetTasksRequest = 7,
        GetTasksResponse = 8,
        GetConditionsRequest = 9,
        GetConditionsResponse = 10,
        SavePlatformRequest = 11,
        SaveDeviceRequest = 13,
        SaveScenarioRequest = 15,
        SaveTaskRequest = 17,
        SaveConditionRequest = 19,
        DeleteDeviceRequest = 33,
        DeleteScenarioRequest = 35,
        DeleteTaskRequest = 37,
        DeleteConditionRequest = 39
    };
public:
    UCtrlLocalApi(UPlatformsModel* platforms, QObject* parent = 0);

    void getDevices(UPlatform* platform);
    void getScenarios(UDevice* device);
    void getTasks(UScenario* scenario);
    void getConditions(UTask* task);

    void savePlatform(UPlatform* platform);
    void saveDevice(UDevice* device);
    void saveDevice(UPlatform* platform, const QJsonArray& deviceArray);
    void saveScenario(UScenario* scenario);
    void saveScenario(UPlatform* platform, UDevice* device, const QJsonArray& scenarioArray);
    void saveTask(UTask* task);
    void saveTask(UPlatform* platform, UScenario* scenario, const QJsonArray& taskArray);
    void saveCondition(UCondition* condition);
    void saveCondition(UPlatform* platform, UTask* task, const QJsonArray& conditionArray);

    void deleteDevice(UDevice* device);
    void deleteDevice(UPlatform* platform, UDevice* device);
    void deleteScenario(UScenario* scenario);
    void deleteScenario(UPlatform* platform, UScenario* scenario);
    void deleteTask(UTask* task);
    void deleteTask(UPlatform* platform, UTask* task);
    void deleteCondition(UCondition* condition);
    void deleteCondition(UPlatform* platform, UCondition* condition);

private:
    QUdpSocket* m_socket;
    QHostAddress m_multicastAddress;
    int m_multicastPort;
    UPlatformsModel* m_platforms;
    QMap<int, void*> m_messageProperties;

    int m_idGenerator;
    int nextId() { return ++m_idGenerator; }

    void sendGetRequest(const QString& address, int port, UEMessageType messageType, const QString& additionalKey, const QString& additionalValue, void* property);
    void sendSaveRequest(const QString& address, int port, UEMessageType messageType, const QString& saveKey, const QJsonArray& jsonArray);
    void sendSaveRequest(const QString& address, int port, UEMessageType messageType, const QString& saveKey, const QJsonArray& jsonArray, const QString& additionalKey, const QString& additionalValue);
    void sendDeleteRequest(const QString& address, int port, UEMessageType messageType, const QString& idKey, const QString& idValue);

private slots:
    void processPendingDatagrams();
};

#endif // UCTRLLOCALAPI_H
