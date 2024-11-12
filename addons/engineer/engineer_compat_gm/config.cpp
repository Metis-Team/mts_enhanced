#include "script_component.hpp"

class CfgPatches {
    class SUBADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            QUOTE(ADDON),
            "gm_vehicles_land_tracked_bpz2"
        };
        skipWhenMissingDependencies = 1;
        author = ECSTRING(main,authors);
        authors[] = {"Timi007"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;

        addonRootClass = QUOTE(ADDON);
    };
};

#include "CfgVehicles.hpp"
