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

void DestroyTaskBuilder(UTaskBuilder* taskBuilder)
{
    if (taskBuilder == NULL)
        return;

    delete taskBuilder;
    taskBuilder = NULL;
}

void TestAddTaskToScenario(UScenarioBuilder& scenarioBuilder)
{
    UTaskBuilder* taskBuilder1 = scenarioBuilder.createTask();
    taskBuilder1->setName("newTask1");
    taskBuilder1->setStatus("10%");
    taskBuilder1->notifyTaskUpdate();

    UTaskBuilder* taskBuilder2 = scenarioBuilder.createTask();
    taskBuilder2->setName("newTask2");
    taskBuilder2->setStatus("50%");
    taskBuilder2->notifyTaskUpdate();

    UTaskBuilder* taskBuilder3 = scenarioBuilder.createTask();
    taskBuilder3->setName("newTask3");
    taskBuilder3->setStatus("80%");
    taskBuilder3->notifyTaskUpdate();

    DestroyTaskBuilder(taskBuilder1);
    DestroyTaskBuilder(taskBuilder2);
    DestroyTaskBuilder(taskBuilder3);
}

void PrintTask(const UTask* task)
{
    qDebug(task->m_name.c_str());
    qDebug(task->m_status.c_str());
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QtQuick2ApplicationViewer viewer;

    // this is for testing
    UScenarioBuilder scenarioBuilder(NULL);
    TestAddTaskToScenario(scenarioBuilder);

    const UScenario* scenario = scenarioBuilder.getScenario();
    UScenarioModel scenarioModel(&scenarioBuilder);

    const UTask* task1 = scenario->taskAt(0);
    const UTask* task2 = scenario->taskAt(1);
    const UTask* task3 = scenario->taskAt(2);

    PrintTask(task1);
    PrintTask(task2);
    PrintTask(task3);

    UTaskBuilder* taskBuilder1 = scenarioBuilder.editTask(task1->id());
    taskBuilder1->setStatus("20%");
    taskBuilder1->notifyTaskUpdate();

    scenarioBuilder.deleteTask(task2->id());

    DestroyTaskBuilder(taskBuilder1);

    QQmlContext *ctxt = viewer.rootContext();
    ctxt->setContextProperty("myScenarioModel", &scenarioModel);  

    viewer.setMainQmlFile(QStringLiteral("qml/uCtrlDesktopQml/main.qml"));
    viewer.showExpanded();

    long long id = UniqueIdGenerator::GenerateUniqueId();
    return app.exec();
}
