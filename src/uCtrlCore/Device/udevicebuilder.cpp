#include "udevicebuilder.h"
#include "../Utility/uniqueidgenerator.h"

UDeviceBuilder::UDeviceBuilder()
{
    m_device.m_id = UniqueIdGenerator::GenerateUniqueId();
}

UDeviceBuilder::UDeviceBuilder(const UDevice& device)
{
    m_device = device;
}

void UDeviceBuilder::setName(const std::string& status)
{
    m_device.m_name = status;
}

UDeviceInfoBuilder* UDeviceBuilder::createDeviceInfo()
{
    return new UDeviceInfoBuilder(new UDeviceInfo());
}

UScenarioBuilder* UDeviceBuilder::createScenario()
{
    return new UScenarioBuilder(this);
}

UScenarioBuilder* UDeviceBuilder::editScenario(int scenarioId)
{
    for (int i = 0; i < m_device.m_scenarios.size(); ++i)
    {
        if (m_device.m_scenarios[i].m_id == scenarioId)
        {
            UScenarioBuilder* scenarioBuilder = new UScenarioBuilder(this/*, m_device.m_scenarios[i]*/);
            return scenarioBuilder;
        }
    }
}

void UDeviceBuilder::deleteScenario(int scenarioId)
{
    for (int i = 0; i < m_device.m_scenarios.size(); ++i)
    {
        if (m_device.m_scenarios[i].m_id == scenarioId)
        {
            std::vector<UScenario>::iterator iter = m_device.m_scenarios.begin() + i;

            m_device.m_scenarios.erase(iter);

            // TODO : Notify device scenario deleted
            return;
        }
    }
}

void UDeviceBuilder::onScenarioUpdated(const UScenario& updatedScenario)
{
    for (int i = 0; i < m_device.m_scenarios.size(); ++i)
    {
        if (m_device.m_scenarios[i].m_id == updatedScenario.m_id)
        {
            std::vector<UScenario>::iterator iter = m_device.m_scenarios.begin() + i;

            m_device.m_scenarios.erase(iter);
            m_device.m_scenarios.insert(iter, updatedScenario);

            // TODO : Notify device scenario edited
            return;
        }
    }

    m_device.m_scenarios.push_back(updatedScenario);
    // TODO : Notify device scenario added
}
