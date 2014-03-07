#include "udevicebuilder.h"
#include "../Utility/uniqueidgenerator.h"

UDeviceBuilder::UDeviceBuilder()
{
}

UDeviceBuilder::UDeviceBuilder(UDevice* device)
    : m_device(device)
{
}

UScenarioBuilder* UDeviceBuilder::createScenario()
{
    return new UScenarioBuilder(this);
}

UScenarioBuilder* UDeviceBuilder::editScenario(int scenarioId)
{
    for (int i = 0; i < m_device->m_deviceScenarios.size(); ++i)
    {
        if (m_device->m_deviceScenarios[i].m_id == scenarioId)
        {
            UScenarioBuilder* scenarioBuilder = new UScenarioBuilder(this, m_device->m_deviceScenarios[i]);
            return scenarioBuilder;
        }
    }
}

void UDeviceBuilder::deleteScenario(int scenarioId)
{
    for (int i = 0; i < m_device->m_deviceScenarios.size(); ++i)
    {
        if (m_device->m_deviceScenarios[i].m_id == scenarioId)
        {
            std::vector<UScenario>::iterator iter = m_device->m_deviceScenarios.begin() + i;

            m_device->m_deviceScenarios.erase(iter);

            // TODO : Notify device scenario deleted
            return;
        }
    }
}

void UDeviceBuilder::onScenarioUpdated(const UScenario& updatedScenario)
{
    for (int i = 0; i < m_device->m_deviceScenarios.size(); ++i)
    {
        if (m_device->m_deviceScenarios[i].m_id == updatedScenario.m_id)
        {
            std::vector<UScenario>::iterator iter = m_device->m_deviceScenarios.begin() + i;

            m_device->m_deviceScenarios.erase(iter);
            m_device->m_deviceScenarios.insert(iter, updatedScenario);

            // TODO : Notify device scenario edited
            return;
        }
    }

    m_device->m_deviceScenarios.push_back(updatedScenario);
    // TODO : Notify device scenario added
}
