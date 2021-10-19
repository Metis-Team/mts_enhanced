#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"mts_main"};
        author = ECSTRING(main,authors);
        authors[] = {"Timi007"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgWorlds.hpp"
#include "CfgVehicles.hpp"
