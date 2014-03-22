#include <QString>
#include <QtTest>

class TestController : public QObject
{
    Q_OBJECT

public:
    TestController();

private Q_SLOTS:
    void testCase1();
};

TestController::TestController()
{
}

void TestController::testCase1()
{
    QVERIFY2(true, "Failure");
}

QTEST_APPLESS_MAIN(TestController)

#include "tst_testcontroller.moc"
