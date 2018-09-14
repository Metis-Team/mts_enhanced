#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {
            "MTS_Box_Ammo_Base",
            "MTS_Box_Ammo_Light",
            "MTS_Box_Ammo_Heavy",
            "MTS_Box_Ammo_Night"
        };
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"mts_main", "bwa3_weapons", "ace_chemlights", "ace_grenades", "hlcweapons_MG3s"};
        author = "";
        authors[] = {"PhILoX", "Timi007"};
        VERSION_CONFIG;
    };
};

#include "CfgVehicles.hpp"
