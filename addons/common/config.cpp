#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"mts_main", "ace_common", "ace_interact_menu"};
        author = "";
        authors[] = {"PhILoX", "Timi007"};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
