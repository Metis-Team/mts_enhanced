private _listOptions = [
    ["adminLogged", "admin", "all", "disabled"],
    [LSTRING(adminLogged), LSTRING(admin), LSTRING(all), LSTRING(disabled)],
    0
];

private _category = [format ["%1 - %2", LELSTRING(main,category), LLSTRING(category)]];

{
    _x params ["_command"];

    [
        format [QGVAR(%1), _command],
        "LIST",
        [format ["#%1", _command], LLSTRING(availableFor)],
        _category,
        _listOptions,
        1,
        {},
        true
    ] call CBA_fnc_addSetting;
} forEach GVAR(commands);
