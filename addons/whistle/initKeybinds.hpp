[
    LLSTRING(cba_keybinding_categoryName),
    QGVAR(blowWhistle),
    LLSTRING(cba_keybinding_blow_whistle),
    {
        call FUNC(blowWhistle);
    },
    "",
    [0x23, [false, true, false]] //Ctrl + H
] call CBA_fnc_addKeybind;
