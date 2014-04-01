#include <QtGui/QGuiApplication>
#include <QTranslator>
#include "qtquick2applicationviewer.h"
#include <qqmlengine.h>
#include <qqmlcontext.h>
#include <qqml.h>
#include <QtQuick/qquickitem.h>
#include <QtQuick/qquickview.h>
#include "System/usystem.h"
#include "Serialization/jsonserializer.h"
#include "Network/unetworkscanner.h"

#include <QFile>
#include <QTextStream>

void SaveSystemToFile(USystem* s, std::string filename)
{
    QFile file(QString::fromStdString(filename));
    file.open(QIODevice::WriteOnly | QIODevice::Text);
    QTextStream out(&file);
    out << JsonSerializer::serialize(s);

    // optional, as QFile destructor will already do it:
    file.close();
}

void LoadSystemFromFile(USystem* s, std::string filename)
{
    QFile f(QString::fromStdString(filename));
    if (f.open(QFile::ReadOnly | QFile::Text)){
        QTextStream in(&f);
        QString str = in.readAll();
        str.remove(QRegExp("[\\n\\t\\r]"));
        JsonSerializer::parse(str, s);
    }
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QtQuick2ApplicationViewer viewer;

    QTranslator translator;
    if (translator.load(":/Resources/Languages/uctrl_" + QLocale::system().name())) {
        app.installTranslator(&translator);
    }

    UNetworkScanner* scanner = UNetworkScanner::Instance();
    scanner->scanNetwork();

    USystem* system = USystem::Instance();
    LoadSystemFromFile(system, ":/Resources/data.json");

    UPlatform* platform = new UPlatform(system, "127.0.0.1", 5000);

    QQmlContext *ctxt = viewer.rootContext();
    UDevice* d = system->getPlatforms().first()->getDevices()[0];
    ctxt->setContextProperty("myDevice", d);

    viewer.setMainQmlFile(QStringLiteral("qml/uCtrlDesktopQml/main.qml"));
    viewer.setMinimumHeight(700);
    viewer.setMinimumWidth(900);
    viewer.showExpanded();

    int ret = app.exec();

    //SaveSystemToFile(system, "data.json");
    return ret;
}

