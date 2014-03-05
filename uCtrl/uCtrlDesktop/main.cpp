#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include <qqmlengine.h>
#include <qqmlcontext.h>
#include <qqml.h>
#include <QtQuick/qquickitem.h>
#include <QtQuick/qquickview.h>
#include "../uCtrlCore/Scenario/uscenario.h"
#include "../uCtrlCore/Utility/uniqueidgenerator.h"

int main(int argc, char *argv[])
{

    QGuiApplication app(argc, argv);
/*
    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/uCtrlDesktopQml/main.qml"));


    viewer.showExpanded();
*/

    long long id = UniqueIdGenerator::GenerateUniqueId();
    return app.exec();
}
