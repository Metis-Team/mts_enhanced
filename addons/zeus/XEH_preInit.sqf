#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

[
    QGVAR(enableACEUnconsciousIcon),
    "CHECKBOX",
    [LLSTRING(ACEUnconsciousIcon), format [LELSTRING(main,settingCheckboxDescription), LLSTRING(ACEUnconsciousIcon)]],
    LELSTRING(main,settingCategoryCommon),
    false,
    0,
    {}
] call CBA_Settings_fnc_init;

ADDON = true;
