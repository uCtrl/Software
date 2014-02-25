#ifndef UTASKSBUILDER_H
#define UTASKSBUILDER_H

class UTasksBuilder
{
public:
    UTasksBuilder();
    ~UTasksBuilder();

    void AddTask();
    void EditTask();
    void DeleteTask();

private:
    bool IsDirty;
};

#endif // UTASKSBUILDER_H
