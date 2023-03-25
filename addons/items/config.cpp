#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {
            QGVAR(marker_yellow_item),
            QGVAR(marker_mines_item)
        };
        weapons[] = {
            QGVAR(marker_yellow),
            QGVAR(marker_mines)
        };
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"mts_main", "ace_interact_menu", "ace_common", "ace_interaction"};
        author = ECSTRING(main,authors);
        authors[] = {"Timi007", "Dan"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"
