#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(PBWLoaded) = [["PBW_German_Uniform", "PBW_German_Common"]] call EFUNC(common,areModsLoaded);

[
    QGVAR(enabled),
    "CHECKBOX",
    [LLSTRING(cords), format [LELSTRING(main,settingCheckboxDescription), LLSTRING(cords)]],
    LELSTRING(main,settingCategoryCommon),
    true,
    0,
    {}
] call CBA_fnc_addSetting;

[
    QGVAR(playerIDs),
    "EDITBOX",
    [LLSTRING(playerIDs), LLSTRING(playerIDs_tooltip)],
    LELSTRING(main,settingCategoryCommon),
    "[""""]",
    1,
    {}
] call CBA_fnc_addSetting;

ADDON = true;
