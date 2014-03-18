#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include <qqmlengine.h>
#include <qqmlcontext.h>
#include <qqml.h>
#include <QtQuick/qquickitem.h>
#include <QtQuick/qquickview.h>
#include "Models/Scenario/uscenariomodel.h"
#include "Scenario/uscenario.h"
#include "Utility/uniqueidgenerator.h"
#include "Scenario/uscenariobuilder.h"
#include "Device/udevice.h"
#include "Device/udevicebuilder.h"
#include "Device/udevicesummary.h"
#include "Device/udevicesummarybuilder.h"
#include "Models/Device/udevicemodel.h"
#include <QFile>
#include <QTextStream>

#include <sstream>

void PrintFloat(float number)
{
    std::ostringstream buffer;
    buffer << number;
    std::string str = buffer.str();
    qDebug(str.c_str());
}

void PrintDeviceInfo(const UDeviceInfo* info) {
    PrintFloat(info->m_minValue);
    PrintFloat(info->m_maxValue);
}

void PrintTask(const UTask& task)
{
    qDebug(task.m_name.c_str());
    qDebug(task.m_status.c_str());
}

void PrintScenario(const UScenario& scenario) {
    qDebug(scenario.m_name.c_str());
    const std::vector<UTask>& tasks = scenario.m_tasks;
    for (int i=0; i<tasks.size(); i++) {
        PrintTask(tasks.at(i));
    }
}

void PrintDevice(const UDevice* device) {
    qDebug(device->m_name.c_str());
    PrintDeviceInfo(device->m_deviceInfo);

    const std::vector<UScenario>& scenarios = device->m_scenarios;
    for (int i=0; i<scenarios.size(); i++) {
        PrintScenario(scenarios.at(i));
    }
}

void SaveDeviceToFile(const UDevice* device, std::string filename){

    QFile file(QString::fromStdString(filename));
    file.open(QIODevice::WriteOnly | QIODevice::Text);
    QTextStream out(&file);
    out << QString::fromStdString(device->Serialize());

    // optional, as QFile destructor will already do it:
    file.close();
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QtQuick2ApplicationViewer viewer;

    // this is for testing devices
    std::string names[] = {"Temperature", "Infrared", "Motion", "Plug"};
    std::string units[] = {"celcius", "boolean", "boolean", "boolean"};
    std::string scenarios[] = { "Semaine", "Week-end", "Vacances" };
    std::string status[] = {"10%", "20%" };

    //const UDevice* device;
    //for (int i=0; i<4; i++) {
    int i=0;
    // Creating Device Object
    UDeviceBuilder deviceBuilder;
    deviceBuilder.setId(UniqueIdGenerator::GenerateUniqueId());
    deviceBuilder.setName(names[i]);

    // Creating Device's informations
    UDeviceInfoBuilder* infoBuilder = deviceBuilder.createDeviceInfo();
    infoBuilder->setMin(0.0 + i);
    infoBuilder->setMax(100.0 + i);
    infoBuilder->setPrecision(i);
    infoBuilder->setUnitLabel(units[i]);
    infoBuilder->setType(i + 1);

    // Creating Device's scenario
    int j=0;
    UScenarioBuilder* scenarioBuilder = deviceBuilder.createScenario();
    scenarioBuilder->setName(scenarios[j]);

    for (int k=0; k<2; k++) {
        // Creating Scenario's task
        UTaskBuilder* taskBuilder = scenarioBuilder->createTask();
        taskBuilder->setName("newTask1");
        taskBuilder->setStatus(status[k]);

        UConditionBuilder* condBuilder = taskBuilder->createCondition();
        condBuilder->notifyConditionUpdate();

        delete condBuilder;
        condBuilder = taskBuilder->createCondition();
        condBuilder->notifyConditionUpdate();
        delete condBuilder;
        condBuilder = NULL;

        taskBuilder->notifyTaskUpdate();
        delete taskBuilder;
        taskBuilder = NULL;
    }

    scenarioBuilder->notifyScenarioUpdate();

    deviceBuilder.setIp("127.0.0.1");
    deviceBuilder.setName(names[i]);

    deviceBuilder.setDeviceInfo(infoBuilder->getDeviceInfo());

    UDeviceModel deviceModel(&deviceBuilder);
    UScenarioModel scenarioModel(scenarioBuilder);
    deviceModel.setScenarioModel(&scenarioModel);

    QQmlContext *ctxt = viewer.rootContext();
    ctxt->setContextProperty("myDevice", &deviceModel);

    viewer.setMainQmlFile(QStringLiteral("qml/uCtrlDesktopQml/main.qml"));
    viewer.showExpanded();

    SaveDeviceToFile(deviceModel.device(), "deviceJSON.txt");
    long long id = UniqueIdGenerator::GenerateUniqueId();
    return app.exec();
}
