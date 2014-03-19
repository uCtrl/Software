#ifndef USYSTEM_H
#define USYSTEM_H

#include "Serialization/JsonMacros.h"
#include "Platform/uplatform.h"

BEGIN_DECLARE_JSON_CLASS_ARGS1(USystem, std::vector<UPlatform>, m_platforms)

public:
    USystem(const USystem& system);

    const std::vector<UPlatform>& getAllPlatforms() const { return m_platforms; }


END_DECLARE_JSON_CLASS()

#endif // USYSTEM_H
