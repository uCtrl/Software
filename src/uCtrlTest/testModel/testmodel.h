#ifndef TESTMODEL_H
#define TESTMODEL_H

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
#include "../../uCtrlCore/Conditions/uconditiondevice.h"

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
void testConditionDeviceJson();

//Slots
void testPlatformSlots();
void testDeviceSlots();
void testScenarioSlots();
void testTaskSlots();
void testConditionSlots();
void testConditionDateSlots();
void testConditionTimeSlots();
void testConditionWeekDaySlots();
void testConditionDeviceSlots();


private:
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
int con_dev_id = 1;
float con_dev_begin_value = 1.0;
float con_dev_end_value = 2.0;
int condition_weekday = 2;
UCondition::UEConditionType conditionType = UCondition::UEConditionType::Date;
UCondition::UEComparisonType comparisonType = UCondition::UEComparisonType::InBetween;
UConditionDate::UEConditionDateType dateType = UConditionDate::UEConditionDateType::DDMMYYYY;
UConditionDevice::UEDeviceType deviceType = UConditionDevice::UEDeviceType::ElectricPlug;


};

#endif // TESTMODEL_H
