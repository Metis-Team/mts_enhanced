#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"mts_main"};
        author = CSTRING(authors);
        authors[] = {"PhILoX"};
        url = CSTRING(URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
