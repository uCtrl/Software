#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include <qqmlengine.h>
#include <qqmlcontext.h>
#include <qqml.h>
#include <QtQuick/qquickitem.h>
#include <QtQuick/qquickview.h>
#include "../uCtrlDesktop/Models/Scenario/uscenariomodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QtQuick2ApplicationViewer viewer;

    // this is for testing
    UScenario scenario;
    UScenarioModel scenarioModel(scenario); 
    scenarioModel.addTask(new UTask("11%"));
    scenarioModel.addTask(new UTask("13%"));
    scenarioModel.addTask(new UTask("12%"));
	                                        
    QQmlContext *ctxt = viewer.rootContext();
    ctxt->setContextProperty("myScenarioModel", &scenarioModel);  

    viewer.setMainQmlFile(QStringLiteral("qml/uCtrlDesktopQml/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
