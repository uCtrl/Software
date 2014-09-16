#include <QAudioRecorder>

#include "uaudiorecorder.h"

UAudioRecorder::UAudioRecorder(QObject* parent) : QObject(parent) {
    m_audioRecorder = new QAudioRecorder(this);

    //TODO: It will work for Mac and Windows, but I'm not sure about linux. We'll need to wait for the packagers to be done.
    #ifdef Q_OS_MAC
        QUrl url = QUrl::fromLocalFile(QDir::cleanPath(QCoreApplication::applicationDirPath() + "/../Resources/clip.wav"));
    #else
        QUrl url = QUrl::fromLocalFile(QDir::cleanPath(QCoreApplication::applicationDirPath() + "/clip.wav"));
    #endif

    m_audioRecorder->setOutputLocation(url);
}

void UAudioRecorder::toggleRecord() {
    if (m_audioRecorder->state() == QMediaRecorder::RecordingState) {
        m_audioRecorder->stop();
        emit recordingStopped();
    }
    else {
        m_audioRecorder->record();
        emit recordingStarted();
    }
}

QString UAudioRecorder::getOutputLocation() {
    return m_audioRecorder->outputLocation().toLocalFile();
}
