#include "usystem.h"
#include "sstream"

USystem::USystem()
{

}

USystem::USystem(const USystem& system)
{
    this->m_platforms = system.m_platforms;
}

void USystem::FillObject(json::Object &obj) const
{
    obj["platforms_size"] = (int) m_platforms.size();
    for (int i = 0; i < m_platforms.size(); i++)
    {
        std::ostringstream oss;
        oss << "platforms [" << i << "]";

        std::string key = oss.str();
        obj[key] = m_platforms[i].ToObject();
    }
}

void USystem::FillMembers(const json::Object &obj)
{
    int m_platforms_size = obj["platforms_size"];
    for (int i = 0; i < m_platforms_size; i++)
    {
        std::ostringstream oss;
        oss << "platforms[" << i << "]";

        std::string key = oss.str();
        UPlatform platform = UPlatform::Deserialize(obj[key]);
        m_platforms.push_back(platform);
    }
}
