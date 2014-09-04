#ifndef UAUDIORECORDER_H
#define UAUDIORECORDER_H

#include <QAudioRecorder>
#include <QUrl>
#include <QDir>
#include <QCoreApplication>

class UAudioRecorder : public QObject {
    Q_OBJECT

public:
    UAudioRecorder(QObject* parent = 0);
    Q_INVOKABLE void toggleRecord();
    Q_INVOKABLE QString getOutputLocation();

signals:
    void recordingStarted();
    void recordingStopped();

private:
    QAudioRecorder* m_audioRecorder;
};

#endif // UAUDIORECORDER_H
