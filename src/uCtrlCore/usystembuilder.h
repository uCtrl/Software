#ifndef USYSTEMBUILDER_H
#define USYSTEMBUILDER_H

#include "usystem.h"
#include "Platform/uplatform.h"
#include "Platform/uplatformbuilder.h"

class USystemBuilder
{
public:
    USystemBuilder();
    USystemBuilder(const USystem& system);
    void loadFromJsonString( std::string data);

    UPlatformBuilder* createPlatform();
    UPlatformBuilder* editPlatform(int platformId);
    void deletePlatform(int platformId);

    const USystem* getSystem() const { return &m_system; }

private:
    USystem m_system;
};

#endif // USYSTEMBUILDER_H
