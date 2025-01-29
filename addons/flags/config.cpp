#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {
            QGVAR(white),
            QGVAR(red),
            QGVAR(blue),
            QGVAR(green),
            QGVAR(yellow),
            QGVAR(orange),
            QGVAR(purple),
            QGVAR(black)
        };
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"mts_main", "ace_flags"};
        author = ECSTRING(main,authors);
        authors[] = {"Timi007"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgWeapons.hpp"
