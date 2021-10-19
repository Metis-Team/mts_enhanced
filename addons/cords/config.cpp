#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"mts_main","mts_common","ace_interact_menu"};
        author = CSTRING(authors);
        authors[] = {"PhILoX","Timi007"};
        url = CSTRING(URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
