[
    QGVAR(openUIActionMenu),
    "LIST",
    [LLSTRING(openUIActionMenu), LLSTRING(openUIActionMenu_tooltip)],
    [LELSTRING(main,category), LLSTRING(displayName)],
    [["ace_interaction","scroll_menu"],[LLSTRING(openUIActionMenu_ace_interaction), LLSTRING(openUIActionMenu_scroll_menu)],0],
    1,
    {}
] call CBA_settings_fnc_init;

[
    QGVAR(allowPlayerDBConnection),
    "CHECKBOX",
    [LLSTRING(allowPlayerDBConnection), LLSTRING(allowPlayerDBConnection_tooltip)],
    [LELSTRING(main,category), LLSTRING(displayName)],
    false,
    0,
    {},
    true
] call CBA_fnc_addSetting;

