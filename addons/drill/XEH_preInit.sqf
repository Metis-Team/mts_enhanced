#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

[
    QGVAR(UIEnabled),
    "CHECKBOX",
    [LLSTRING(showUI), LLSTRING(showUI_tooltip)],
    [LELSTRING(main,category), LLSTRING(subCategory)],
    true,
    0,
    {
        QGVAR(UILayer) cutText ["", "PLAIN"];
    }
] call CBA_fnc_addSetting;

ADDON = true;
