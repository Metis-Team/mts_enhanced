#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

if ("PBW_German_Uniform" call ace_common_fnc_isModLoaded) then {
    #include "initSettings.hpp"
};

ADDON = true;
