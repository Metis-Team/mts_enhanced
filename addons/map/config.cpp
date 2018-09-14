#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"mts_main","ace_interact_menu","ace_common","a3_ui_f"};
        author = "";
        authors[] = {"Timi007"};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
