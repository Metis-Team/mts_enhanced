#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

[
    QGVAR(UIEnabled),
    "CHECKBOX",
    [LLSTRING(UI_Setting), format [LELSTRING(main,settingCheckboxDescription), LLSTRING(UI_Setting)]],
    LELSTRING(main,settingCategoryCommon),
    true,
    0,
    {
        cutText ["", "PLAIN"];
    }
] call CBA_fnc_addSetting;

ADDON = true;
