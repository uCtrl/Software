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
#include "UCtrl/uctrlapi.h"
#include "Audio/uaudiorecorder.h"
#include "Voice/uvoicecontrolapi.h"

#include <QFile>
#include <QTextStream>

#include <QtQml>

void Init(QGuiApplication& app, QtQuick2ApplicationViewer& viewer)
{
    QTranslator translator;
    if (translator.load(":/Resources/Languages/uctrl_" + QLocale::system().name())) {
        app.installTranslator(&translator);
    }

    qmlRegisterType<UCondition>("ConditionEnums", 1, 0, "UEConditionType");
    qmlRegisterType<UCondition>("ConditionEnums", 1, 0, "UEComparisonType");
    qmlRegisterType<UConditionWeekday>("ConditionEnums", 1, 0, "UEWeekday");
    qmlRegisterType<UConditionDevice>("ConditionEnums", 1, 0, "UEDeviceType");
    qmlRegisterType<UAudioRecorder>("UAudioRecorder", 1, 0, "UAudioRecorder");
    qmlRegisterType<UVoiceControlAPI>("UVoiceControl", 1, 0, "UVoiceControl");
    
    USystem* system = USystem::Instance();

    QNetworkAccessManager* networkAccessManager = viewer.engine()->networkAccessManager();
    UCtrlAPI* uCtrlApi = new UCtrlAPI(networkAccessManager);
    uCtrlApi->getSystem();

    QQmlContext *ctxt = viewer.rootContext();
    ctxt->setContextProperty("mySystem", system);
    ctxt->setContextProperty("uctrlApi", uCtrlApi);

    viewer.setMainQmlFile(QStringLiteral("qml/uCtrlDesktopQml/main.qml"));
    viewer.setMinimumHeight(650);
    viewer.setMinimumWidth(900);
    viewer.showExpanded();
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QtQuick2ApplicationViewer viewer;

    // TODO: Extract this to a class and speed up initialization with QMetaObject::invokeMethod(this, "init",!Qt::QueuedConnection);
    Init(app, viewer);

    return app.exec();
}

