#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include <qqmlengine.h>
#include <qqmlcontext.h>
#include <qqml.h>
#include <QtQuick/qquickitem.h>
#include <QtQuick/qquickview.h>
#include "../uCtrlCore/Scenario/uscenario.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    UScenario scenarioModel;
    scenarioModel.addTask(new UTask());

    QtQuick2ApplicationViewer viewer;
    QQmlContext *ctxt = viewer.rootContext();
    ctxt->setContextProperty("myScenarioModel", &scenarioModel);
    viewer.setMainQmlFile(QStringLiteral("qml/uCtrlDesktopQml/main.qml"));

    QObject *item = viewer.rootObject()->findChild<QObject*>("btn");
    QObject::connect(item, SIGNAL(qmlSignal()), &scenarioModel, SLOT(cppSlot()));

    viewer.showExpanded();

    return app.exec();
}
