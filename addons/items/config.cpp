#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {
            QGVAR(item_base),
            QGVAR(red_item),
            QGVAR(blue_item),
            QGVAR(green_item),
            QGVAR(yellow_item)
        };
        weapons[] = {
            QGVAR(base),
            QGVAR(red),
            QGVAR(blue),
            QGVAR(green),
            QGVAR(yellow)
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
