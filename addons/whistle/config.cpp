#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {
            QGVAR(FOX40_Item)
        };
        weapons[] = {
            QGVAR(FOX40)
        };
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"mts_main"};
        author = ECSTRING(main,authors);
        authors[] = {"Timi007"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"
#include "CfgSounds.hpp"
