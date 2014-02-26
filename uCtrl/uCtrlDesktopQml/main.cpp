#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/uCtrlDesktopQml/main.qml"));
    viewer.showExpanded();
    //viewer.showMaximized();

    return app.exec();
}
