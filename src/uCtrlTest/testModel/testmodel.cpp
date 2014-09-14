#include "testmodel.h"

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
    QCOMPARE(platform->getDevices(), platform_list);

}

void TestModel::testUDeviceJson()
{
    UDevice* device = new UDevice();
    QDateTime device_date = QDateTime();
    QList<UScenario*> device_list = device->getScenarios();
    device->setId(device_id);
    device->setName(device_name);
    device->setScenarios(device_list);
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
    QCOMPARE(device->getScenarios(), device_list);

}

//WIP udeviceList doesn't seem to be serializeable
/*void TestModel::testUDeviceListJson()
{
    UDeviceList* devicelist = new UDeviceList();
    QList<UDevice*> device_list = devicelist->getDevices();

    devicelist->setDevices(device_list);

    QString json = JsonSerializer::serialize(devicelist);

    UDeviceList* parseDeviceList = new UDeviceList();
    JsonSerializer::parse(json, parseDeviceList);

    QCOMPARE(devicelist->getDevices(), parseDeviceList->getDevices());

}*/

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
    QCOMPARE(scenario->getTasks(), scenario_list);

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
    QCOMPARE(task->getConditions(), task_list);

}

void TestModel::testConditionJson()
{
    UCondition* condition = new UCondition();
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
    UConditionDate* conditionDate = new UConditionDate();
    UConditionDate::UEConditionDateType dateType = UConditionDate::UEConditionDateType::DDMMYYYY;
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

    conditionWeekDay->setComparisonType(comparisonType);
    conditionWeekDay->setSelectedWeekdays(condition_weekday);

    QString json = JsonSerializer::serialize(conditionWeekDay);

    UConditionWeekday* parseConditionWeekDay = new UConditionWeekday();
    parseConditionWeekDay->setComparisonType(comparisonType);
    parseConditionWeekDay->setSelectedWeekdays(condition_weekday);

    JsonSerializer::parse(json, parseConditionWeekDay);

    QCOMPARE(conditionWeekDay->getComparisonType(), parseConditionWeekDay->getComparisonType());
    QCOMPARE(conditionWeekDay->getSelectedWeekdays(), parseConditionWeekDay->getSelectedWeekdays());
}

void TestModel::testConditionDeviceJson()
{
    UConditionDevice* conditionDevice = new UConditionDevice();

    conditionDevice->setDeviceType(deviceType);
    conditionDevice->setDeviceId(con_dev_id);
    conditionDevice->setBeginValue(con_dev_begin_value);
    conditionDevice->setEndValue(con_dev_end_value);

    QString json = JsonSerializer::serialize(conditionDevice);

    UConditionDevice* parseConditionDevice = new UConditionDevice();
    parseConditionDevice->setDeviceType(deviceType);
    parseConditionDevice->setDeviceId(con_dev_id);
    parseConditionDevice->setBeginValue(con_dev_begin_value);
    parseConditionDevice->setEndValue(con_dev_end_value);
    JsonSerializer::parse(json, parseConditionDevice);

    QCOMPARE(conditionDevice->getDeviceType(), parseConditionDevice->getDeviceType());
    QCOMPARE(conditionDevice->getDeviceId(), parseConditionDevice->getDeviceId());
    QCOMPARE(conditionDevice->getBeginValue(), parseConditionDevice->getBeginValue());
    QCOMPARE(conditionDevice->getEndValue(), parseConditionDevice->getEndValue());

}

//Slots test section
void TestModel::testPlatformSlots()
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

    QCOMPARE(platform->getId(), platform_id);
    QCOMPARE(platform->getIp(), platform_ip);
    QCOMPARE(platform->getPort(), platform_port);
    QCOMPARE(platform->getDevices(), platform_list);
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
    QList<UScenario*> device_list = device->getScenarios();
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
    QCOMPARE(device->getScenarios(), device_list);

    QVERIFY2(device_id > test_value, "Error! Device id value is invalid");
    QVERIFY2(device_type > test_value, "Error! Device type value is invalid");
    QVERIFY2(device_precision > test_value, "Error! Device precision value is invalid");
    QVERIFY2(device_status > test_value, "Error! Device status value is invalid");
    QVERIFY2(device_maxvalue >= device_minvalue, "Error! Min value is greater than max value");
}

void TestModel::testUDeviceListSlots()
{
    UDeviceList* deviceList = new UDeviceList;
    QList<UDevice*> device_list = deviceList->getDevices();

    QCOMPARE(deviceList->getDevices(), device_list);

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
   UCondition* condition = new UCondition();
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
    //UConditionWeekday::UEWeekday weekday = UConditionWeekday::UEWeekday::Friday;
    //It seem there is an error in uconditionweekday.h,
    //int getSelectedWeekdays should be UEWeekday getSelectedWeekdays

    conditionWeekDay->setComparisonType(comparisonType);
    conditionWeekDay->setSelectedWeekdays(condition_weekday);

    QCOMPARE(conditionWeekDay->getComparisonType(), comparisonType);
    QCOMPARE(conditionWeekDay->getSelectedWeekdays(), condition_weekday);
}

void TestModel::testConditionDeviceSlots()
{
    UConditionDevice* conditionDevice = new UConditionDevice();

    conditionDevice->setDeviceType(deviceType);
    conditionDevice->setDeviceId(con_dev_id);
    conditionDevice->setBeginValue(con_dev_begin_value);
    conditionDevice->setEndValue(con_dev_end_value);

    QCOMPARE(conditionDevice->getDeviceType(), deviceType);
    QCOMPARE(conditionDevice->getDeviceId(), con_dev_id);
    QCOMPARE(conditionDevice->getBeginValue(), con_dev_begin_value);
    QCOMPARE(conditionDevice->getEndValue(), con_dev_end_value);

    QVERIFY2(con_dev_end_value > con_dev_begin_value, "Error! BeginValue is greather than EndValue.");
}

QTEST_APPLESS_MAIN(TestModel)
