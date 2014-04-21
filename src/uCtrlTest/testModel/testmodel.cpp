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

    //Slots
    void testSystemSlots();
    void testPlatformSlots();
    void testDeviceSlots();
    void testScenarioSlots();
    void testTaskSlots();
    void testConditionSlots();
    void testConditionDateSlots();
    void testConditionTimeSlots();
    void testConditionWeekDaySlots();
};

TestModel::TestModel()
{
}

//Public slots tests section

void TestModel::testSystemSlots()
{
    USystem* system = USystem::Instance();
    QList<UPlatform*> list = system->getPlatforms();
    system->setPlatforms(list);
    QCOMPARE(system->getPlatforms(), list);
}

void TestModel::testPlatformSlots()
{
    UPlatform* platform = new UPlatform();
    QList<UDevice*> list = platform->getDevices();
    platform->setId(-23);
    platform->setIp("127.0.0.1");
    platform->setPort(-5000);
    platform->setDevices(list);
    platform->setName("Platform");
    platform->setRoom("Room");
    platform->setEnabled("True");
    platform->setFirmwareVersion("1.0.1");
    QCOMPARE(platform->getId() , -23);
    QCOMPARE(platform->getIp(), QString("127.0.0.1"));
    QCOMPARE(platform->getPort(), -5000);
    QCOMPARE(platform->getDevices(), list);
    QCOMPARE(platform->getName(), QString("Platform"));
    QCOMPARE(platform->getRoom(), QString("Room"));
    QCOMPARE(platform->getEnabled(), QString("True"));
    QCOMPARE(platform->getFirmwareVersion(), QString("1.0.1"));
}

void TestModel::testDeviceSlots()
{
    UDevice* device = new UDevice();
    QDateTime date = QDateTime();
    device->setId(3);
    device->setName("Light");
    device->setMinValue(2.0);
    device->setMaxValue(4.0);
    device->setPrecision(5);
    device->setUnitLabel("");
    device->setType(3);
    device->setIsTriggerValue(true);
    device->setDescription("Description");
    device->setEnabled("Enabled");
    device->setStatus(5.0);
    device->setLastUpdate(date);

    QCOMPARE(device->getId(), 3);
    QCOMPARE(device->getName(), QString("Light"));
    QCOMPARE(device->getMinValue(), 2.0);
    QCOMPARE(device->getMaxValue(), 4.0);
    QCOMPARE(device->getPrecision(), 5);
    QCOMPARE(device->getUnitLabel(), QString(""));
    QCOMPARE(device->getType(), 3);
    QCOMPARE(device->isTriggerValue(), true);
    QCOMPARE(device->getDescription(), QString("Description"));
    QCOMPARE(device->getEnabled(), QString("Enabled"));
    QCOMPARE(device->getStatus(), 5.0);
    QCOMPARE(device->getLastUpdate(), date);
}

void TestModel::testScenarioSlots()
{
    UScenario* scenario = new UScenario();
    QList<UTask*> list = scenario->getTasks();
    scenario->setId(3);
    scenario->setName("Travail");
    scenario->setTasks(list);

    QCOMPARE(scenario->getId(), 3);
    QCOMPARE(scenario->getName(), QString("Travail"));
    QCOMPARE(scenario->getTasks(), list);
}

void TestModel::testTaskSlots()
{
    UTask* task = new UTask();
    QList<UCondition*> list = task->getConditions();
    task->setId(3);
    task->setStatus("Enabled");
    task->setConditions(list);
    QCOMPARE(task->getId(), 3);
    QCOMPARE(task->getStatus(), QString("Enabled"));
    QCOMPARE(task->getConditions(), list);
}

void TestModel::testConditionSlots()
{
    //TODO : test setConditionParent
    UCondition* condition = new UCondition();
    UCondition::UEConditionType conditionType;
    UCondition::UEComparisonType comparisonType;
    condition->setId(56);
    condition->setType(conditionType);
    condition->setComparisonType(comparisonType);

    QCOMPARE(condition->getId(), 56);
    QCOMPARE(condition->getType(), conditionType);
    QCOMPARE(condition->getComparisonType(), comparisonType);
}

void TestModel::testConditionDateSlots()
{
    UConditionDate* conditionDate = new UConditionDate();
    UConditionDate::UEConditionDateType dateType;
    QDate beginDate = QDate();
    QDate endDate = QDate();

    beginDate.setDate(2014,04,16);
    endDate.setDate(2014,04,17);

    conditionDate->setDateType(dateType);
    conditionDate->setBeginDate(beginDate);
    conditionDate->setEndDate(endDate);

    QCOMPARE(conditionDate->getDateType(), dateType);
    QCOMPARE(conditionDate->getBeginDate(), beginDate);
    QCOMPARE(conditionDate->getEndDate(), endDate);
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
