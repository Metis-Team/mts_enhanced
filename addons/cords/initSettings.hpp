[
    QGVAR(enabled),
    "CHECKBOX",
    [LLSTRING(cords), LLSTRING(cords_tooltip)],
    [LELSTRING(main,category), LLSTRING(subCategory)],
    true,
    0,
    {}
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
