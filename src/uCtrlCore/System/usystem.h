#ifndef USYSTEM_H
#define USYSTEM_H

#include "Serialization/JsonMacros.h"
#include "Platform/uplatform.h"

BEGIN_DECLARE_JSON_CLASS_ARGS1(USystem, std::vector<UPlatform>, Platforms)

public:
    USystem(const USystem& system);

END_DECLARE_JSON_CLASS()

#endif // USYSTEM_H
