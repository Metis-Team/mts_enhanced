#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {
            "BWA3_optic_ZO4x30_NSV",
            "BWA3_optic_ZO4x30_IRV",
            "BWA3_optic_20x50_NSV",
            "BWA3_optic_24x72_NSV"
        };
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"mts_main", "bwa3_optics"};
        author = "";
        authors[] = {"PhILoX"};
        VERSION_CONFIG;
    };
};

#include "CfgWeapons.hpp"
