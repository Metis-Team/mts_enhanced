[
    QGVAR(enableACEUnconsciousIcon),
    "CHECKBOX",
    [LLSTRING(ACEUnconsciousIcon), LLSTRING(ACEUnconsciousIconTooltip)],
    [LELSTRING(main,category), LLSTRING(subCategory)],
    true,
    0,
    {}
] call CBA_fnc_addSetting;

[
    QGVAR(enable3DENComments),
    "CHECKBOX",
    [LLSTRING(3DENComments), LLSTRING(3DENCommentsTooltip)],
    [LELSTRING(main,category), LLSTRING(subCategory)],
    true,
    0
] call CBA_fnc_addSetting;

[
    QGVAR(3DENCommentsColor),
    "COLOR",
    [LLSTRING(3DENCommentsColor), LLSTRING(3DENCommentsColorTooltip)],
    [LELSTRING(main,category), LLSTRING(subCategory)],
    [0, 1, 0.75, 1],
    0,
] call CBA_fnc_addSetting;
