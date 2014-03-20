#include "usystembuilder.h"

USystemBuilder::USystemBuilder()
{
}

USystemBuilder::USystemBuilder(const USystem &system)
{
    m_system = system;
}

void USystemBuilder::loadFromJsonString(std::string data)
{
    this->m_system = USystem::Deserialize(json::Deserialize(data));
}

UPlatformBuilder* USystemBuilder::createPlatform()
{
    return new UPlatformBuilder();
}

UPlatformBuilder* USystemBuilder::editPlatform(int platformId)
{
    for (int i = 0; i < m_system.m_platforms.size(); i++)
    {
        if (m_system.m_platforms[i].m_id == platformId)
        {
            UPlatformBuilder* platformBuilder = new UPlatformBuilder(m_system.m_platforms[i]);
            return platformBuilder;
        }
    }
}

void USystemBuilder::deletePlatform(int platformId)
{
    for (int i = 0; i < m_system.m_platforms.size(); i++)
    {
        if (m_system.m_platforms[i].m_id == platformId)
        {
            std::vector<UPlatform>::iterator iter = m_system.m_platforms.begin() + i;
            m_system.m_platforms.erase(iter);
            return;
        }
    }
}
