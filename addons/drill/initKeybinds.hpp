[
    [LELSTRING(main,category), LLSTRING(subCategory)],
    "StandStill",
    LLSTRING(StandStill),
    {QGVAR(StandStill) call FUNC(playAnimation);},
    {false},
    [0x3B,  [false, false, false]], //F1
    false
] call CBA_fnc_addKeybind;

[
    [LELSTRING(main,category), LLSTRING(subCategory)],
    "AtEase",
    LLSTRING(AtEase),
    {QGVAR(AtEase) call FUNC(playAnimation);},
    {false},
    [0x3C,  [false, false, false]], //F2
    false
] call CBA_fnc_addKeybind;

[
    [LELSTRING(main,category), LLSTRING(subCategory)],
    "FY",
    LLSTRING(FY),
    {QGVAR(FY) call FUNC(playAnimation);},
    {false},
    [-1,  [false, false, false]], //Not defined
    false
] call CBA_fnc_addKeybind;

// adding salute keybind eventhandler
private _actionKeys = [];
{
    if (((str _x) find ".") isEqualTo -1) then {
        _actionKeys pushback _x;
    };
} forEach actionKeys "Salute";
TRACE_1("Salute Keys",_actionKeys);
{
    [_x, [false, false, false], {QGVAR(Salute) call FUNC(playAnimation)}] call CBA_fnc_addKeyHandler;
} forEach _actionKeys;
