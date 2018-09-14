#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {
            "MTS_Flag_Item_Base",
            "MTS_Flag_Red_Item",
            "MTS_Flag_Blue_Item",
            "MTS_Flag_Green_Item",
            "MTS_Flag_Yellow_Item"
        };
        weapons[] = {
            "MTS_Flag_Base",
            "MTS_Flag_Red",
            "MTS_Flag_Blue",
            "MTS_Flag_Green",
            "MTS_Flag_Yellow"
        };
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"mts_main", "ace_interact_menu", "ace_common", "ace_interaction"};
        author = "";
        authors[] = {"Timi007", "Dan"};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"
