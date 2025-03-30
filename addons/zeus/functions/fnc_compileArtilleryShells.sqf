#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Finds all HE howitzer and mortar shells and caches them in uiNamespace.
 *
 *  Parameter(s):
 *      None
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      call mts_zeus_fnc_compileArtilleryShells
 *
 */

private _ordnanceHowitzer = [];
private _ordnanceMortar = [];
private _cfgAmmo = configFile >> "CfgAmmo";

{
    private _cfg = _x;
    private _cfgName = configName _cfg;

    private _isHowitzer = _cfgName isKindOf "ModuleOrdnanceHowitzer_F";
    private _isMortar = !_isHowitzer && {_cfgName isKindOf "ModuleOrdnanceMortar_F"} && {!(_cfgName isKindOf "ModuleOrdnanceRocket_F")};

    if !(_isHowitzer || _isMortar) then {continue};

    private _ammo = getText (_cfg >> "ammo");
    private _ammoCfg = _cfgAmmo >> _ammo;

    // Filter non-shells, smoke and illum shells
    if (
        (getText (_ammoCfg >> "warheadName") != "HE") ||
        {(getText (_ammoCfg >> "simulation") != "shotShell") && {getText (_ammoCfg >> "simulation") != "shotSubmunitions"}} ||
        {_ammo isKindOf ["gm_shell_artillery_smoke_Base", _cfgAmmo]} ||
        {_ammo isKindOf ["gm_shell_155mm_smoke_base", _cfgAmmo]}
    ) then {continue};

    private _displayName = getText (_cfg >> "displayName");

    private _ordnance = switch (true) do {
        case (_isHowitzer): {_ordnanceHowitzer};
        case (_isMortar): {_ordnanceMortar};
        default {[]};
    };

    // Ignore duplicates
    if (_ordnance findIf {(_x select 1 == _displayName) && {_x select 2 == _ammo}} isNotEqualTo -1) then {continue};

    private _dlcName = _cfg call ace_common_fnc_getAddon;
    private _logo = "";
    if (_dlcName isNotEqualTo "") then {
        _logo = (modParams [_dlcName, ["logo"]]) param [0, ""];
    };

    _ordnance pushBack [_cfgName, _displayName, _ammo, _logo];
} forEach configProperties [configFile >> "CfgVehicles", "isClass _x && {getNumber (_x >> 'scopeCurator') == 2}"];

uiNamespace setVariable [QGVAR(howitzerShellsCache), [_ordnanceHowitzer, 1] call CBA_fnc_sortNestedArray];
uiNamespace setVariable [QGVAR(mortarShellsCache), [_ordnanceMortar, 1] call CBA_fnc_sortNestedArray];
