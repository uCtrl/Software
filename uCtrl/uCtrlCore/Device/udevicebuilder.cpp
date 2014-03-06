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
    for (int i = 0; i < m_device->deviceScenarios.size(); ++i)
    {
        if (m_device->deviceScenarios[i].id == scenarioId)
        {
            UScenarioBuilder* scenarioBuilder = new UScenarioBuilder(this, m_device->deviceScenarios[i]);
            return scenarioBuilder;
        }
    }
}

void UDeviceBuilder::deleteScenario(int scenarioId)
{
    for (int i = 0; i < m_device->deviceScenarios.size(); ++i)
    {
        if (m_device->deviceScenarios[i].id == scenarioId)
        {
            std::vector<UScenario>::iterator iter = m_device->deviceScenarios.begin() + i;

            m_device->deviceScenarios.erase(iter);

            // TODO : Notify device scenario deleted
            return;
        }
    }
}

void UDeviceBuilder::onScenarioUpdated(const UScenario& updatedScenario)
{
    for (int i = 0; i < m_device->deviceScenarios.size(); ++i)
    {
        if (m_device->deviceScenarios[i].id == updatedScenario.id)
        {
            std::vector<UScenario>::iterator iter = m_device->deviceScenarios.begin() + i;

            m_device->deviceScenarios.erase(iter);
            m_device->deviceScenarios.insert(iter, updatedScenario);

            // TODO : Notify device scenario edited
            return;
        }
    }

    m_device->deviceScenarios.push_back(updatedScenario);
    // TODO : Notify device scenario added
}
