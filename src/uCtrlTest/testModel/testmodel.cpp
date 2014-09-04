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

//Slots
void testPlatformSlots();
void testDeviceSlots();
void testScenarioSlots();
void testTaskSlots();
void testConditionSlots();
void testConditionDateSlots();
void testConditionTimeSlots();
void testConditionWeekDaySlots();

};

//Value for testint purpose
int test_value = -1;

//platform
int platform_id = 23;
QString platform_ip ="127.0.0.1";
int platform_port = 5000;
QString platform_name = "Platform";
QString platform_room = "Room";
QString platform_enb = "True";
QString platform_firmware = "1.0.1";

//device
int device_id = 3;
QString device_name = "Ligth";
float device_minvalue = 2.0;
float device_maxvalue = 4.0;
int device_precision = 5;
QString device_unitlabel = "";
int device_type = 3;
bool device_trigger = true;
QString device_description ="Description";
QString device_enabled = "Enabled";
float device_status = 5.0;

//Scenario
int scenario_id = 3;
QString scenario_name = "Travail";

//Task
int task_id = 3;
QString task_status = "Enabled";

//condition
int condition_id = 56;

TestModel::TestModel()
{
}

//Serialization test section

void TestModel::testUPlatformJson()
{

    UPlatform* platform = new UPlatform();
    QList<UDevice*> platform_list = platform->getDevices();
    platform->setId(platform_id);
    platform->setIp(platform_ip);
    platform->setPort(platform_port);
    platform->setDevices(platform_list);
    platform->setName(platform_name);
    platform->setRoom(platform_room);
    platform->setEnabled(platform_enb);
    platform->setFirmwareVersion(platform_firmware);


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

}

void TestModel::testUDeviceJson()
{
    UDevice* device = new UDevice();
    QDateTime device_date = QDateTime();
    device->setId(device_id);
    device->setName(device_name);
    device->setMinValue(device_minvalue);
    device->setMaxValue(device_maxvalue);
    device->setPrecision(device_precision);
    device->setUnitLabel(device_unitlabel);
    device->setType(device_type);
    device->setIsTriggerValue(device_trigger);
    device->setDescription(device_description);
    device->setEnabled(device_enabled);
    device->setStatus(device_status);
    device->setLastUpdate(device_date);

    QString json = JsonSerializer::serialize(device);

    UDevice* parseDevice = new UDevice();
    JsonSerializer::parse(json, parseDevice);

    QList<UScenario*> device_list = device->getScenarios();

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

}

void TestModel::testScenarioJson()
{
    UScenario* scenario = new UScenario();
    QList<UTask*> scenario_list = scenario->getTasks();
    scenario->setId(scenario_id);
    scenario->setName(scenario_name);
    scenario->setTasks(scenario_list);

    QString json = JsonSerializer::serialize(scenario);
    UScenario* parseScenario = new UScenario();
    JsonSerializer::parse(json, parseScenario);

    QCOMPARE(scenario->getId(), parseScenario->getId());
    QCOMPARE(scenario->getName(), parseScenario->getName());
    QCOMPARE(scenario->getTasks(), parseScenario->getTasks());

}

void TestModel::testTaskJson()
{
    UTask* task = new UTask();
    QList<UCondition*> task_list = task->getConditions();
    task->setId(task_id);
    task->setStatus(task_status);
    task->setConditions(task_list);

    QString json = JsonSerializer::serialize(task);
    UTask* parseTask = new UTask();
    JsonSerializer::parse(json, parseTask);

    QCOMPARE(task->getId(), parseTask->getId());
    QCOMPARE(task->getStatus(), parseTask->getStatus());
    QCOMPARE(task->getConditions(), parseTask->getConditions());

}

void TestModel::testConditionJson()
{
    //TODO : test setConditionParent
    UCondition* condition = new UCondition();
    UCondition::UEConditionType conditionType;
    UCondition::UEComparisonType comparisonType;
    condition->setId(condition_id);
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

    beginDate.setDate(2014,04,16);
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

//Slots test section
void TestModel::testPlatformSlots()
{
    UPlatform* platform = new UPlatform();
    QList<UDevice*> list = platform->getDevices();
    platform->setId(platform_id);
    platform->setIp(platform_ip);
    platform->setPort(platform_port);
    platform->setDevices(list);
    platform->setName(platform_name);
    platform->setRoom(platform_room);
    platform->setEnabled(platform_enb);
    platform->setFirmwareVersion(platform_firmware);

    QCOMPARE(platform->getId(), platform_id);
    QCOMPARE(platform->getIp(), platform_ip);
    QCOMPARE(platform->getPort(), platform_port);
    QCOMPARE(platform->getDevices(), list);
    QCOMPARE(platform->getName(), platform_name);
    QCOMPARE(platform->getRoom(), platform_room);
    QCOMPARE(platform->getEnabled(), platform_enb);
    QCOMPARE(platform->getFirmwareVersion(), platform_firmware);

    QVERIFY2(platform_id > test_value, "Error! Platform id value is invalid");
    QVERIFY2(platform_port >= 0 && platform_port <= 55000, "Error! Platform port value is invalid");

}

void TestModel::testDeviceSlots()
{
    UDevice* device = new UDevice();
    QDateTime device_date = QDateTime();
    device->setId(device_id);
    device->setName(device_name);
    device->setMinValue(device_minvalue);
    device->setMaxValue(device_maxvalue);
    device->setPrecision(device_precision);
    device->setUnitLabel(device_unitlabel);
    device->setType(device_type);
    device->setIsTriggerValue(device_trigger);
    device->setDescription(device_description);
    device->setEnabled(device_enabled);
    device->setStatus(device_status);
    device->setLastUpdate(device_date);

    QCOMPARE(device->getId(), device_id);
    QCOMPARE(device->getName(), device_name);
    QCOMPARE(device->getMinValue(), device_minvalue);
    QCOMPARE(device->getMaxValue(), device_maxvalue);
    QCOMPARE(device->getPrecision(), device_precision);
    QCOMPARE(device->getUnitLabel(), device_unitlabel);
    QCOMPARE(device->getType(), device_type);
    QCOMPARE(device->isTriggerValue(), device_trigger);
    QCOMPARE(device->getDescription(), device_description);
    QCOMPARE(device->getEnabled(), device_enabled);
    QCOMPARE(device->getStatus(), device_status);
    QCOMPARE(device->getLastUpdate(), device_date);

    QVERIFY2(device_id > test_value, "Error! Device id value is invalid");
    QVERIFY2(device_type > test_value, "Error! Device type value is invalid");
    QVERIFY2(device_precision > test_value, "Error! Device precision value is invalid");
    QVERIFY2(device_status > test_value, "Error! Device status value is invalid");
    QVERIFY2(device_maxvalue >= device_minvalue, "Error! Min value is greater than max value");
}

void TestModel::testScenarioSlots()
{
    UScenario* scenario = new UScenario();
    QList<UTask*> scenario_list = scenario->getTasks();
    scenario->setId(scenario_id);
    scenario->setName(scenario_name);
    scenario->setTasks(scenario_list);

    QCOMPARE(scenario->getId(), scenario_id);
    QCOMPARE(scenario->getName(), scenario_name);
    QCOMPARE(scenario->getTasks(), scenario_list);

    QVERIFY2(scenario->getId() > test_value, "Error! Scenario id value is invalid");
}

void TestModel::testTaskSlots()
{
    UTask* task = new UTask();
    QList<UCondition*> task_list = task->getConditions();
    task->setId(task_id);
    task->setStatus(task_status);
    task->setConditions(task_list);

    QCOMPARE(task->getId(), task_id);
    QCOMPARE(task->getStatus(), task_status);
    QCOMPARE(task->getConditions(), task_list);

    QVERIFY2(task->getId() > test_value, "Error! Task id value is invalid");
}

void TestModel::testConditionSlots()
{
   //TODO : test setConditionParent
   UCondition* condition = new UCondition();
   UCondition::UEConditionType conditionType;
   UCondition::UEComparisonType comparisonType;
   condition->setId(condition_id);
   condition->setType(conditionType);
   condition->setComparisonType(comparisonType);

   QCOMPARE(condition->getId(), condition_id);
   QCOMPARE(condition->getType(), conditionType);
   QCOMPARE(condition->getComparisonType(), comparisonType);

   QVERIFY2(condition->getId() > test_value, "Error! Condition id value is invalid");
}
void TestModel::testConditionDateSlots()
{
    UConditionDate* conditionDate = new UConditionDate();
    UConditionDate::UEConditionDateType dateType;
    QDate beginDate = QDate();
    QDate endDate = QDate();

    beginDate.setDate(2012,04,16);
    endDate.setDate(2014,04,17);

    conditionDate->setDateType(dateType);
    conditionDate->setBeginDate(beginDate);
    conditionDate->setEndDate(endDate);

    QCOMPARE(conditionDate->getDateType(), dateType);
    QCOMPARE(conditionDate->getBeginDate(), beginDate);
    QCOMPARE(conditionDate->getEndDate(), endDate);

    QVERIFY2(endDate.operator >(beginDate), "Error! End date is before begin date");
}
void TestModel::testConditionTimeSlots()
{
    UConditionTime* conditionTime = new UConditionTime();
    QTime beginTime = QTime();
    QTime endTime = QTime();

    beginTime.setHMS(3,14,00);
    endTime.setHMS(5,14,00);

    conditionTime->setBeginTime(beginTime);
    conditionTime->setEndTime(endTime);

    QCOMPARE(conditionTime->getBeginTime(), beginTime);
    QCOMPARE(conditionTime->getEndTime(), endTime);

    QVERIFY2(endTime.operator >(beginTime), "Error! End time is before begin time");
}
void TestModel::testConditionWeekDaySlots()
{
    UConditionWeekday* conditionWeekDay = new UConditionWeekday();
    UCondition::UEComparisonType comparisonType;

    conditionWeekDay->setComparisonType(comparisonType);

    QCOMPARE(conditionWeekDay->getComparisonType(), comparisonType);
}

QTEST_APPLESS_MAIN(TestModel)
#include "testmodel.moc"
