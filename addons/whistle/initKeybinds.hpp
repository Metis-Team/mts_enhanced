[
    [LELSTRING(main,category), LLSTRING(subCategory)],
    QGVAR(blowWhistle),
    LLSTRING(cba_keybinding_blow_whistle),
    {
        private _player = call CBA_fnc_currentUnit;
        [_player] call FUNC(blowWhistle);
    },
    "",
    [0x23, [false, true, false]] //Ctrl + H
] call CBA_fnc_addKeybind;
