#include "uscenariobuilder.h"
#include "uscenario.h"


UScenarioBuilder::UScenarioBuilder()
{

}

UScenarioBuilder::UScenarioBuilder(UScenario const &uscenario)
{
     UScenario* tempUScenario = new UScenario(uscenario);
}

UScenarioBuilder::~UScenarioBuilder()
{

}

void UScenarioBuilder::AddScenario()
{

}

void UScenarioBuilder::EditScenrio()
{

}

void UScenarioBuilder::DeleteScenario()
{

}


void UScenarioBuilder::NotifyScenarioUpdate(int ID, UScenario &tempScenario)
{

}


