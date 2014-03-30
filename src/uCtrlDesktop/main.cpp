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

#include <QFile>
#include <QTextStream>

void SaveDeviceToFile(UDevice* device, std::string filename)
{
    QFile file(QString::fromStdString(filename));
    file.open(QIODevice::WriteOnly | QIODevice::Text);
    QTextStream out(&file);
    out << JsonSerializer::serialize(device);

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

    USystem* system = new USystem();
    LoadSystemFromFile(system, ":/Resources/JSON.txt");

    QQmlContext *ctxt = viewer.rootContext();
    UDevice* d = system->getPlatforms().first()->getDevices()[0];
    ctxt->setContextProperty("myDevice", d);

    viewer.setMainQmlFile(QStringLiteral("qml/uCtrlDesktopQml/main.qml"));
    viewer.showExpanded();

    return app.exec();
}

