#include <QString>
#include <QtTest>

class TestView : public QObject
{
    Q_OBJECT

public:
    TestView();

private Q_SLOTS:
    void testCase1();
};

TestView::TestView()
{
}

void TestView::testCase1()
{
    QVERIFY2(true, "Failure");
}

QTEST_APPLESS_MAIN(TestView)
#include "testview.moc"
