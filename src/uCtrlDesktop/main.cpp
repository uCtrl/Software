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
#include "Device/udevice.h"
#include "Device/udevicebuilder.h"
#include "Models/Device/udevicemodel.h"
#include "Conditions/ucondition.h"
#include "Conditions/uconditionbuilder.h"
#include "Conditions/uconditiondate.h"
#include <QFile>
#include <QTextStream>

#include <sstream>

void SaveDeviceToFile(const UDevice* device, std::string filename){

    QFile file(QString::fromStdString(filename));
    file.open(QIODevice::WriteOnly | QIODevice::Text);
    QTextStream out(&file);
    out << QString::fromStdString(device->Serialize());

    // optional, as QFile destructor will already do it:
    file.close();
}

void LoadDeviceFromFile( UDeviceBuilder& db, std::string filename){

    QFile f(QString::fromStdString(filename));
    if (f.open(QFile::ReadOnly | QFile::Text)){
        QTextStream in(&f);
        QString str = in.readAll();
        str.remove(QRegExp("[\\n\\t\\r]"));
        db.loadFromJsonString(str.toStdString());
    }
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QtQuick2ApplicationViewer viewer;

    UDeviceBuilder db;
    LoadDeviceFromFile(db, ":/Resources/JSON.txt");
    UDeviceModel dm( &db );

    QQmlContext *ctxt = viewer.rootContext();
    ctxt->setContextProperty("myDevice", &dm);

    viewer.setMainQmlFile(QStringLiteral("qml/uCtrlDesktopQml/main.qml"));
    viewer.showExpanded();

    return app.exec();
}

