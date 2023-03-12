#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(PBWLoaded) = [["PBW_German_Uniform", "PBW_German_Common"]] call EFUNC(common,areModsLoaded);

[
    QGVAR(enabled),
    "CHECKBOX",
    [LLSTRING(cords), LLSTRING(cords_tooltip)],
    [LELSTRING(main,category), LLSTRING(subCategory)],
    true,
    0,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(playerIDs),
    "EDITBOX",
    [LLSTRING(playerIDs), LLSTRING(playerIDs_tooltip)],
    [LELSTRING(main,category), LLSTRING(subCategory)],
    "[""""]",
    1,
    {},
    true
] call CBA_fnc_addSetting;

ADDON = true;
