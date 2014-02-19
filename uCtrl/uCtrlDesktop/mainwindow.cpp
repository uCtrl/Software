#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_pushButton_clicked()
{
// Test stuff PROOF OF CONCEPT
    UDeviceInfo deviceInfo;
    deviceInfo.MaxValue = 5.0f;
    deviceInfo.MinValue = 0.0f;
    deviceInfo.Precision = 0;
    deviceInfo.Type = 3;
    deviceInfo.UnitLabel = "blarg test!";

    json::Object o;
    o["MaxValue"] = deviceInfo.MaxValue;
    o["MinValue"] = deviceInfo.MinValue;
    o["Precision"] = deviceInfo.Precision;
    o["Type"] = deviceInfo.Type;
    o["UnitLabel"] = deviceInfo.UnitLabel;

    QString text = QString::number(deviceInfo.MaxValue);
    std::string serializedDeviceInfo = json::Serialize(o);

    QString testText = QString::fromStdString(serializedDeviceInfo);
    ui->textEdit->setText(testText);


}
