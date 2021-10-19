#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {"MTS_ItemWhistle"};
        weapons[] = {"MTS_Whistle"};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"mts_main"};
        author = CSTRING(authors);
        authors[] = {"Timi007"};
        url = CSTRING(URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"
#include "CfgSounds.hpp"
