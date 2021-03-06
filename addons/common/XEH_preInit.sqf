#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

// Print version to rpt log
private _version = getText (configFile >> "CfgPatches" >> "mts_main" >> "versionStr");
INFO_1("Metis Enhanced version: %1.", _version);

//grasscutter on/off
[
    QGVAR(grasscutter_enabled),
    "CHECKBOX",
    [LLSTRING(grasscutter), format [LELSTRING(main,settingCheckboxDescription),LLSTRING(grasscutter)]],
    LELSTRING(main,settingCategoryCommon),
    true,
    0,
    {}
] call CBA_fnc_addSetting;

//grasscutter size
[
    QGVAR(grasscutter_size),
    "LIST",
    [LLSTRING(grasscutter_size), LLSTRING(grasscutter_size_tooltip)],
    LELSTRING(main,settingCategoryCommon),
    [
        [0, 1],
        [LLSTRING(grasscutter_size_large), LLSTRING(grasscutter_size_medium)],
        1
    ],
    0,
    {}
] call CBA_fnc_addSetting;

ADDON = true;
