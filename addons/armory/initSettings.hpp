[
    QGVAR(cba_settings_actions),
    "LIST",
    [LLSTRING(cba_settings_actions), LLSTRING(cba_settings_actions_tooltip)],
    [LELSTRING(main,category), LLSTRING(displayName)],
    [["ace_interaction","scroll_menu"],[LLSTRING(cba_settings_actions_ace_interaction), LLSTRING(cba_settings_actions_scroll_menu)],0],
    1,
    {}
] call CBA_settings_fnc_init;

[
    QGVAR(cba_settings_playerDBConnection),
    "CHECKBOX",
    [LLSTRING(cba_settings_playerDBConnection), LLSTRING(cba_settings_playerDBConnection_tooltip)],
    [LELSTRING(main,category), LLSTRING(displayName)],
    false,
    0,
    {},
    true
] call CBA_fnc_addSetting;

