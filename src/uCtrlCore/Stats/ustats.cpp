#include "ustats.h"

UStats* UStats::m_statsInstance = NULL;

UStats* UStats::Instance()
{
    if(!m_statsInstance)
        m_statsInstance = new UStats();

    return m_statsInstance;
}

void UStats::read(const QJsonObject &jsonObj)
{
}

void UStats::write(QJsonObject &jsonObj) const
{
}
