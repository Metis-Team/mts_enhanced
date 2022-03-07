[
    QGVAR(enableACEUnconsciousIcon),
    "CHECKBOX",
    [LLSTRING(ACEUnconsciousIcon), LLSTRING(ACEUnconsciousIconTooltip)],
    LELSTRING(main,settingCategoryCommon),
    true,
    0,
    {}
] call CBA_fnc_addSetting;

[
    QGVAR(enable3DENComments),
    "CHECKBOX",
    [LLSTRING(3DENComments), LLSTRING(3DENCommentsTooltip)],
    LELSTRING(main,settingCategoryCommon),
    true,
    0,
    {}
] call CBA_fnc_addSetting;
