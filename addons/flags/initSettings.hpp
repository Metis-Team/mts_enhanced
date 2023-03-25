private _category = [LELSTRING(main,category), LLSTRING(SettingCategory)];

[
    QGVAR(enablePlacing), "CHECKBOX",
    [LSTRING(AllowPlacingFlags), LSTRING(AllowPlacingFlagsTooltip)],
    _category,
    true,
    0
] call CBA_fnc_addSetting;

[
    QGVAR(enableCarrying), "CHECKBOX",
    [LSTRING(AllowCarryingFlags), LSTRING(AllowCarryingFlagsTooltip)],
    _category,
    true,
    0
] call CBA_fnc_addSetting;
