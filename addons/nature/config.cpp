#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        #include "CfgPatchesUnits.hpp"
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"mts_main"};
        author = "";
        authors[] = {"Timi007"};
        VERSION_CONFIG;
    };
};

#include "CfgEditorCategories.hpp"
#include "CfgVehicles.hpp"
