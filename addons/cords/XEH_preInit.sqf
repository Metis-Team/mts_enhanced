#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(uniforms) = [
    "PBW_Uniform1_fleck",
    "PBW_Uniform1H_fleck",
    "PBW_Uniform1_tropen",
    "PBW_Uniform1H_tropen",
    "PBW_Uniform2_fleck",
    "PBW_Uniform2_tropen",
    "PBW_Uniform3K_fleck",
    "PBW_Uniform3K_tropen",
    "PBW_Uniform3_fleck",
    "PBW_Uniform3_tropen",
    "PBW_Uniform4K_fleck",
    "PBW_Uniform4K_tropen",
    "PBW_Uniform4_fleck",
    "PBW_Uniform4_tropen"
];

GVAR(PBWLoaded) = false;

if ("PBW_German_Uniform" call ace_common_fnc_isModLoaded) then {
    GVAR(PBWLoaded) = true;
    #include "initSettings.hpp"
};

ADDON = true;
