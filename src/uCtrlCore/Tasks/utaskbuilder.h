#ifndef UTASKSBUILDER_H
#define UTASKSBUILDER_H

#include "utask.h"
#include "utaskbuilderobserver.h"

class UTaskBuilder
{
public:
    UTaskBuilder(UTaskBuilderObserver* taskBuilderObserver);
    UTaskBuilder(UTaskBuilderObserver* taskBuilderObserver, const UTask& task);
    ~UTaskBuilder();

    void setName(const std::string& name);
    void setStatus(const std::string& status);

    const UTask* getTask() { return &m_task; }
    bool         isDirty() { return m_isDirty; }

    void notifyTaskUpdate();

private:
    UTask m_task;
    UTaskBuilderObserver* m_taskBuilderObserver;
    bool m_isDirty;
};

#endif // UTASKSBUILDER_H
