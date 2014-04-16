#include <QString>
#include <QtTest>
#include "../../uCtrlCore/System/usystem.h"
#include "../../uCtrlCore/Device/udevice.h"
#include "../../uCtrlCore/Serialization/jsonserializable.h"
#include "../../uCtrlCore/Serialization/jsonserializer.h"
#include "../../uCtrlCore/Platform/uplatform.h"
#include "../../uCtrlCore/Scenario/uscenario.h"
#include "../../uCtrlCore/Tasks/utask.h"
#include "../../uCtrlCore/Conditions/ucondition.h"
#include "../../uCtrlCore/Conditions/uconditiondate.h"
#include "../../uCtrlCore/Conditions/uconditiontime.h"
#include "../../uCtrlCore/Conditions/uconditionweekday.h"

class TestModel : public QObject
{
    Q_OBJECT

public:
    TestModel();

private Q_SLOTS:

    //Json
    void testUPlatformJson();
    void testUDeviceJson();
    void testScenarioJson();
    void testTaskJson();
    void testConditionJson();
    void testConditionDateJson();
    void testConditionTimeJson();
    void testConditionWeekDayJson();

};

TestModel::TestModel()
{
}

//Seriallization test section

void TestModel::testUPlatformJson()
{
    UPlatform* platform = new UPlatform();
    QList<UDevice*> list = platform->getDevices();
    platform->setId(23);
    platform->setIp("127.0.0.1");
    platform->setPort(5000);
    platform->setDevices(list);
    platform->setName("Platform");
    platform->setRoom("Room");
    platform->setEnabled("true");
    platform->setFirmwareVersion("1.0.1");

    QString json = JsonSerializer::serialize(platform);

    UPlatform* parsePlatform = new UPlatform();
    JsonSerializer::parse(json, parsePlatform);

    QCOMPARE(platform->getId(), parsePlatform->getId());
    QCOMPARE(platform->getIp(), parsePlatform->getIp());
    QCOMPARE(platform->getPort(), parsePlatform->getPort());
    QCOMPARE(platform->getDevices(), parsePlatform->getDevices());
    QCOMPARE(platform->getName(), parsePlatform->getName());
    QCOMPARE(platform->getRoom(), parsePlatform->getRoom());
    QCOMPARE(platform->getEnabled(), parsePlatform->getEnabled());
    QCOMPARE(platform->getFirmwareVersion(), parsePlatform->getFirmwareVersion());
    QCOMPARE(list.count(), 0);
}

void TestModel::testUDeviceJson()
{
    UDevice* device = new UDevice();
    QDateTime date = QDateTime();
    device->setId(3);
    device->setName("Light");
    device->setMinValue(0.0);
    device->setMaxValue(3.0);
    device->setPrecision(1);
    device->setUnitLabel("°C");
    device->setType(34);
    device->setIsTriggerValue(true);
    device->setDescription("Room light");
    device->setEnabled("Enabled");
    device->setStatus(3.0);
    device->setLastUpdate(date);

    QString json = JsonSerializer::serialize(device);

    UDevice* parseDevice = new UDevice();
    JsonSerializer::parse(json, parseDevice);

    QList<UScenario*> list = device->getScenarios();

    QCOMPARE(device->getId(), parseDevice->getId());
    QCOMPARE(device->getName(), parseDevice->getName());
    QCOMPARE(device->getMinValue(), parseDevice->getMinValue());
    QCOMPARE(device->getMaxValue(), parseDevice->getMaxValue());
    QCOMPARE(device->getPrecision(), parseDevice->getPrecision());
    QCOMPARE(device->getUnitLabel(), parseDevice->getUnitLabel());
    QCOMPARE(device->getType(), parseDevice->getType());
    QCOMPARE(device->isTriggerValue(), device->isTriggerValue());
    QCOMPARE(device->getDescription(), device->getDescription());
    QCOMPARE(device->getEnabled(), parseDevice->getEnabled());
    QCOMPARE(device->getStatus(), device->getStatus());
    QCOMPARE(device->getLastUpdate(), device->getLastUpdate());
    QCOMPARE(device->getScenarios(), parseDevice->getScenarios());
    QCOMPARE(list.count(), 0);
}

void TestModel::testScenarioJson()
{
    UScenario* scenario = new UScenario();
    QList<UTask*> list = scenario->getTasks();
    scenario->setId(3);
    scenario->setName("Travail");
    scenario->setTasks(list);

    QString json = JsonSerializer::serialize(scenario);
    UScenario* parseScenario = new UScenario();
    JsonSerializer::parse(json, parseScenario);

    QCOMPARE(scenario->getId(), parseScenario->getId());
    QCOMPARE(scenario->getName(), parseScenario->getName());
    QCOMPARE(scenario->getTasks(), parseScenario->getTasks());
    QCOMPARE(list.count(), 0);
}

void TestModel::testTaskJson()
{
    UTask* task = new UTask();
    QList<UCondition*> list = task->getConditions();
    task->setId(6);
    task->setStatus("ENABLED");
    task->setConditions(list);

    QString json = JsonSerializer::serialize(task);
    UTask* parseTask = new UTask();
    JsonSerializer::parse(json, parseTask);

    QCOMPARE(task->getId(), parseTask->getId());
    QCOMPARE(task->getStatus(), parseTask->getStatus());
    QCOMPARE(task->getConditions(), parseTask->getConditions());
    QCOMPARE(list.count(), 0);
}

void TestModel::testConditionJson()
{
    UCondition* condition = new UCondition();
    UCondition::UEConditionType conditionType;
    UCondition::UEComparisonType comparisonType;
    condition->setId(56);
    condition->setType(conditionType);
    condition->setComparisonType(comparisonType);

    QString json = JsonSerializer::serialize(condition);
    UCondition* parseCondition = new UCondition();
    parseCondition->setType(conditionType);
    parseCondition->setComparisonType(comparisonType);
    JsonSerializer::parse(json, parseCondition);

    QCOMPARE(condition->getId(), parseCondition->getId());
    QCOMPARE(condition->getType(), parseCondition->getType());
    QCOMPARE(condition->getComparisonType(), parseCondition->getComparisonType());
}

void TestModel::testConditionDateJson()
{
    //WIP
    UConditionDate* conditionDate = new UConditionDate();
    UConditionDate::UEConditionDateType dateType;
    QDate beginDate = QDate();
    QDate endDate = QDate();

    beginDate.currentDate();
    endDate.setDate(2014,05,31);

    conditionDate->setDateType(dateType);
    conditionDate->setBeginDate(beginDate);
    conditionDate->setEndDate(endDate);

    QString json = JsonSerializer::serialize(conditionDate);

    UConditionDate* parseConditionDate = new UConditionDate();
    parseConditionDate->setDateType(dateType);
    parseConditionDate->setBeginDate(beginDate);
    parseConditionDate->setEndDate(endDate);

    JsonSerializer::parse(json, parseConditionDate);

    QCOMPARE(conditionDate->getDateType(), parseConditionDate->getDateType());
    QCOMPARE(conditionDate->getBeginDate(), parseConditionDate->getBeginDate());
    QCOMPARE(conditionDate->getEndDate(), parseConditionDate->getEndDate());    
}

void TestModel::testConditionTimeJson()
{
    UConditionTime* conditionTime = new UConditionTime();
    QTime beginTime = QTime();
    QTime endTime = QTime();

    beginTime.setHMS(3,14,00);
    endTime.setHMS(5,14,00);

    conditionTime->setBeginTime(beginTime);
    conditionTime->setEndTime(endTime);

    QString json = JsonSerializer::serialize(conditionTime);

    UConditionTime* parseConditionTime = new UConditionTime();
    parseConditionTime->setBeginTime(beginTime);
    parseConditionTime->setEndTime(endTime);

    JsonSerializer::parse(json, parseConditionTime);

    QCOMPARE(conditionTime->getBeginTime(), parseConditionTime->getBeginTime());
    QCOMPARE(conditionTime->getEndTime(), parseConditionTime->getEndTime());
}

void TestModel::testConditionWeekDayJson()
{
    UConditionWeekday* conditionWeekDay = new UConditionWeekday();
    UCondition::UEComparisonType comparisonType;

    conditionWeekDay->setComparisonType(comparisonType);

    QString json = JsonSerializer::serialize(conditionWeekDay);

    UConditionWeekday* parseConditionWeekDay = new UConditionWeekday();
    parseConditionWeekDay->setComparisonType(comparisonType);

    JsonSerializer::parse(json, parseConditionWeekDay);

    QCOMPARE(conditionWeekDay->getComparisonType(), parseConditionWeekDay->getComparisonType());
}

QTEST_APPLESS_MAIN(TestModel)
#include "testmodel.moc"
