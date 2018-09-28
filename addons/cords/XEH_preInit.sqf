#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

[
    QGVAR(enabled),
    "CHECKBOX",
    [LLSTRING(cords), format [LELSTRING(main,settingCheckboxDescription), LLSTRING(cords)]],
    LELSTRING(main,settingCategoryCommon),
    true,
    0,
    {}
] call CBA_Settings_fnc_init;

ADDON = true;
