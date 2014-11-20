#include <QtGui/QGuiApplication>
#include <QTranslator>
#include <QQmlEngine>
#include <QQmlContext>
#include <QtQml>
#include <qtquick2applicationviewer.h>
#include <QtQuick/QQuickItem>
#include <QtQuick/QQuickView>
#include <QFile>
#include <QTextStream>
#include <QTimer>

#include "Serialization/jsonserializer.h"
#include "Network/unetworkscanner.h"
#include "Audio/uaudiorecorder.h"
#include "Voice/uvoicecontrolapi.h"
#include "Utility/oshandler.h"
#include "Models/nestedlistmodel.h"
#include "Models/nestedlistitem.h"
#include "Platform/uplatformsmodel.h"
#include "Protocol/uctrlapifacade.h"

void LoadSystemFromFile(UPlatformsModel* p, const QString& filename)
{
    QTextCodec::setCodecForLocale(QTextCodec::codecForName("UTF-8"));

    QFile f(filename);
    if (f.open(QFile::ReadOnly | QFile::Text)){
        QTextStream in(&f);
        QByteArray str = in.readAll().toUtf8();
        JsonSerializer::parse(str, p);
    }
}

void Init(QGuiApplication& app, QtQuick2ApplicationViewer& viewer)
{
    QTranslator translator;
    if (translator.load(":/Resources/Languages/uctrl_" + QLocale::system().name())) {
        app.installTranslator(&translator);
    }

    qmlRegisterType<UPlatform>("PlatformEnums", 1, 0, "UEStatus");
    qmlRegisterType<UDevice>("DeviceEnums", 1, 0, "UEStatus");
    qmlRegisterType<UDevice>("DeviceEnums", 1, 0, "UEType");
    qmlRegisterType<UCondition>("ConditionEnums", 1, 0, "UEType");
    qmlRegisterType<UCondition>("ConditionEnums", 1, 0, "UEComparisonType");
    qmlRegisterType<UHistoryLog>("HistoryEnums", 1, 0, "UESeverity");
    qmlRegisterType<UHistoryLog>("HistoryEnums", 1, 0, "UELogType");

    qmlRegisterType<UAudioRecorder>("UAudioRecorder", 1, 0, "UAudioRecorder");
    qmlRegisterType<UVoiceControlResponse>("UVoiceControlResponse", 1, 0, "UVoiceControlResponse");
    qmlRegisterType<UVoiceControlAPI>("UVoiceControl", 1, 0, "UVoiceControl");
    qmlRegisterType<UDevice>("UDevice", 1, 0, "UDevice");

    UPlatformsModel* platforms = new UPlatformsModel();

    QNetworkAccessManager* networkAccessManager = viewer.engine()->networkAccessManager();
    UCtrlAPIFacade* uCtrlApiFacade = new UCtrlAPIFacade(networkAccessManager, platforms);
    UCtrlAPI* uCtrlApi = uCtrlApiFacade->getAPI();

    //LoadSystemFromFile(platforms, ":/data.json");
    uCtrlApiFacade->postUser();

    QQmlContext *ctxt = viewer.rootContext();
    ctxt->setContextProperty("platformsModel", platforms);
    ctxt->setContextProperty("uCtrlApiFacade", uCtrlApiFacade);
    ctxt->setContextProperty("uCtrlApi", uCtrlApi);
    viewer.addImportPath(QStringLiteral(":/qml"));
    viewer.setSource(QUrl("qrc:///qml/main.qml"));
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

