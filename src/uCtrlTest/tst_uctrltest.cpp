#include <QString>
#include <QtTest>

class UCtrlTest : public QObject
{
    Q_OBJECT

public:
    UCtrlTest();

private Q_SLOTS:
    void testCase1();
};

UCtrlTest::UCtrlTest()
{
}

void UCtrlTest::testCase1()
{
    QVERIFY2(true, "Failure");
}

QTEST_APPLESS_MAIN(UCtrlTest)

#include "tst_uctrltest.moc"
