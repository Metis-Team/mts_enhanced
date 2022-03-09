[
    [LELSTRING(main,category), LLSTRING(subCategory)],
    QGVAR(AIStanceUp_Hotkey),
    LLSTRING(cba_keybinding_AIStanceUp),
    {
        if (!isNull curatorCamera) then {
            ["UP"] call FUNC(setAIStance);
        };
    },
    "",
    [0x02, [false, false, false]] //1
] call CBA_fnc_addKeybind;

[
    [LELSTRING(main,category), LLSTRING(subCategory)],
    QGVAR(AIStanceMiddle_Hotkey),
    LLSTRING(cba_keybinding_AIStanceMiddle),
    {
        if (!isNull curatorCamera) then {
            ["MIDDLE"] call FUNC(setAIStance);
        };
    },
    "",
    [0x03, [false, false, false]] //2
] call CBA_fnc_addKeybind;

[
    [LELSTRING(main,category), LLSTRING(subCategory)],
    QGVAR(AIStanceDown_Hotkey),
    LLSTRING(cba_keybinding_AIStanceDown),
    {
        if (!isNull curatorCamera) then {
            ["DOWN"] call FUNC(setAIStance);
        };
    },
    "",
    [0x04, [false, false, false]] //3
] call CBA_fnc_addKeybind;

[
    [LELSTRING(main,category), LLSTRING(subCategory)],
    QGVAR(AIBehaviourCareless_Hotkey),
    LLSTRING(cba_keybinding_AIBehaviourCareless),
    {
        if (!isNull curatorCamera) then {
            ["CARELESS"] call FUNC(setAIBehaviour);
        };
    },
    "",
    [0x05, [false, false, false]] //4
] call CBA_fnc_addKeybind;

[
    [LELSTRING(main,category), LLSTRING(subCategory)],
    QGVAR(AIBehaviourCombat_Hotkey),
    LLSTRING(cba_keybinding_AIBehaviourCombat),
    {
        if (!isNull curatorCamera) then {
            ["COMBAT"] call FUNC(setAIBehaviour);
        };
    },
    "",
    [0x06, [false, false, false]] //5
] call CBA_fnc_addKeybind;

[
    [LELSTRING(main,category), LLSTRING(subCategory)],
    QGVAR(AICombatModeBlue_Hotkey),
    LLSTRING(cba_keybinding_AICombatModeBlue),
    {
        if (!isNull curatorCamera) then {
            ["BLUE"] call FUNC(setAICombatMode);
        };
    },
    "",
    [0x05, [true, false, false]] //SHIFT + 4
] call CBA_fnc_addKeybind;

[
    [LELSTRING(main,category), LLSTRING(subCategory)],
    QGVAR(AICombatModeYellow_Hotkey),
    LLSTRING(cba_keybinding_AICombatModeYellow),
    {
        if (!isNull curatorCamera) then {
            ["YELLOW"] call FUNC(setAICombatMode);
        };
    },
    "",
    [0x06, [true, false, false]] //SHIFT + 5
] call CBA_fnc_addKeybind;

[
    [LELSTRING(main,category), LLSTRING(subCategory)],
    QGVAR(disableAIPathBehaviourPath_Hotkey),
    LLSTRING(cba_keybinding_disableAIPathBehaviourPath),
    {
        if (!isNull curatorCamera) then {
            ["path", false] call FUNC(switchAIPathBehaviour);
        };
    },
    "",
    [0x07, [false, false, false]] //6
] call CBA_fnc_addKeybind;

[
    [LELSTRING(main,category), LLSTRING(subCategory)],
    QGVAR(enableAIPathBehaviourPath_Hotkey),
    LLSTRING(cba_keybinding_enableAIPathBehaviourPath),
    {
        if (!isNull curatorCamera) then {
            ["path", true] call FUNC(switchAIPathBehaviour);
        };
    },
    "",
    [0x08, [false, false, false]] //7
] call CBA_fnc_addKeybind;

[
    [LELSTRING(main,category), LLSTRING(subCategory)],
    QGVAR(disableAIPathBehaviourMove_Hotkey),
    LLSTRING(cba_keybinding_disableAIPathBehaviourMove),
    {
        if (!isNull curatorCamera) then {
            ["move", false] call FUNC(switchAIPathBehaviour);
        };
    },
    "",
    [0x07, [true, false, false]] //SHIFT + 6
] call CBA_fnc_addKeybind;

[
    [LELSTRING(main,category), LLSTRING(subCategory)],
    QGVAR(enableAIPathBehaviourMove_Hotkey),
    LLSTRING(cba_keybinding_enableAIPathBehaviourMove),
    {
        if (!isNull curatorCamera) then {
            ["move", true] call FUNC(switchAIPathBehaviour);
        };
    },
    "",
    [0x08, [true, false, false]] //SHIFT + 7
] call CBA_fnc_addKeybind;
