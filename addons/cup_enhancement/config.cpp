#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"mts_main", "utes", "chernarus", "CUP_Terrains_Noe"};
        author = "";
        authors[] = {"Bix", "PhILoX"};
        VERSION_CONFIG;
    };
};

#include "CfgWorlds.hpp"
