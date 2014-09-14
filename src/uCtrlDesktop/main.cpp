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
#include "Conditions/uconditionweekday.h"
#include "Conditions/uconditiondevice.h"
#include "Stats/ustats.h"

#include <QFile>
#include <QTextStream>

#include <QtQml>

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

    qmlRegisterType<UCondition>("ConditionEnums", 1, 0, "UEConditionType");
    qmlRegisterType<UCondition>("ConditionEnums", 1, 0, "UEComparisonType");
    qmlRegisterType<UConditionWeekday>("ConditionEnums", 1, 0, "UEWeekday");
    qmlRegisterType<UConditionDevice>("ConditionEnums", 1, 0, "UEDeviceType");
    
    USystem* system = USystem::Instance();
    UStats* stats = UStats::Instance();

    // SIMULATOR SECTION
    //UNetworkScanner* scanner = UNetworkScanner::Instance();
    //scanner->scanNetwork();

    // LOCAL FILE SECTION
    LoadSystemFromFile(system, ":/Resources/data.json");

    QQmlContext *ctxt = viewer.rootContext();
    ctxt->setContextProperty("mySystem", system);
    ctxt->setContextProperty("myStats", stats);

    viewer.setMainQmlFile(QStringLiteral("qml/uCtrlDesktopQml/main.qml"));
    viewer.setMinimumHeight(650);
    viewer.setMinimumWidth(900);
    viewer.showExpanded();

    int ret = app.exec();
    SaveSystemToFile(system, "newdata.json");
    return ret;
}

