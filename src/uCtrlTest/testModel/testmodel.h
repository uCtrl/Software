#ifndef TESTMODEL_H
#define TESTMODEL_H

#include <QString>
#include <QtTest>
#include "System/usystem.h"
#include "Device/udevice.h"
#include "Device/udevicelist.h"
#include "Serialization/jsonserializable.h"
#include "Serialization/jsonserializer.h"
#include "Platform/uplatform.h"
#include "Scenario/uscenario.h"
#include "Tasks/utask.h"
#include "Conditions/ucondition.h"
#include "Conditions/uconditiondate.h"
#include "Conditions/uconditiontime.h"
#include "Conditions/uconditionweekday.h"
#include "Conditions/uconditiondevice.h"

// Constant declaration
const int test_value = -1;

//platform
const int platform_id = 23;
const QString platform_ip = "127.0.0.1";
const int platform_port = 5000;
const QString platform_name = "Platform";
const QString platform_room = "Room";
const QString platform_enb = "True";
const QString platform_firmware = "1.0.1";

//device
const int device_id = 3;
const QString device_name = "Light";
const float device_minvalue = 2.0;
const float device_maxvalue = 4.0;
const int device_precision = 5;
const QString device_unitlabel = "";
const int device_type = 3;
const bool device_trigger = true;
const QString device_description = "Description";
const QString device_enabled = "Enabled";
const float device_status = 5.0;

//Scenario
const int scenario_id = 3;
const QString scenario_name = "Travail";

//Task
const int task_id = 3;
const QString task_status = QStringLiteral("Enabled");

//condition
const int condition_id = 56;
const int con_dev_id = 1;
const float con_dev_begin_value = 1.0;
const float con_dev_end_value = 2.0;
const int condition_weekday = 2;
const UCondition::UEConditionType conditionType = UCondition::UEConditionType::Date;
const UCondition::UEComparisonType comparisonType = UCondition::UEComparisonType::InBetween;
const UConditionDate::UEConditionDateType dateType = UConditionDate::UEConditionDateType::DDMMYYYY;
const UConditionDevice::UEDeviceType deviceType = UConditionDevice::UEDeviceType::ElectricPlug;

class TestModel : public QObject
{
    Q_OBJECT

public:
    TestModel();

private Q_SLOTS:
    //Json
    void testUPlatformJson();
    void testUDeviceJson();
    //void testUDeviceListJson();
    void testScenarioJson();
    void testTaskJson();
    void testConditionJson();
    void testConditionDateJson();
    void testConditionTimeJson();
    void testConditionWeekDayJson();
    void testConditionDeviceJson();

    //Slots
    void testPlatformSlots();
    void testDeviceSlots();
    void testUDeviceListSlots();
    void testScenarioSlots();
    void testTaskSlots();
    void testConditionSlots();
    void testConditionDateSlots();
    void testConditionTimeSlots();
    void testConditionWeekDaySlots();
    void testConditionDeviceSlots();
};

#endif // TESTMODEL_H
