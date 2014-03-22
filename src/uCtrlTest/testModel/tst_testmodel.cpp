#include <QString>
#include <QtTest>

class TestModel : public QObject
{
    Q_OBJECT

public:
    TestModel();

private Q_SLOTS:
    void testCase1();
};

TestModel::TestModel()
{
}

void TestModel::testCase1()
{
    QVERIFY2(true, "Failure");
}

QTEST_APPLESS_MAIN(TestModel)

#include "tst_testmodel.moc"
