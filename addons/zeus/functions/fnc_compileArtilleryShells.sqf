#include "script_component.hpp"
/**
 *  Author: Author
 *
 *  Description:
 *      Description
 *
 *  Parameter(s):
 *      0: TYPE - Parameter description
 *
 *  Returns:
 *      TYPE - Description
 *
 *  Example:
 *      _this call mts_zeus_fnc_compileArtilleryShells
 *
 */

private _ordnanceHowitzer = [];
private _ordnanceMortar = [];
private _cfgAmmo = configFile >> "CfgAmmo";
{
    private _cfgName = configName _x;

    // Ignore GM base classes
    if (_cfgName == "gm_ModuleOrdnanceHowitzer_base" || {_cfgName == "gm_ModuleOrdnanceMortar_base"}) then {continue};

    private _isHowitzer = _cfgName isKindOf "ModuleOrdnanceHowitzer_F";
    private _isMortar = !_isHowitzer && {_cfgName isKindOf "ModuleOrdnanceMortar_F"} && {!(_cfgName isKindOf "ModuleOrdnanceRocket_F")};

    if !(_isHowitzer || _isMortar) then {continue};

    private _ammo = getText (_x >> "ammo");

    // Filter smoke and illum shells
    if ((getText (_cfgAmmo >> _ammo >> "warheadName") != "HE") || {_ammo isKindOf ["gm_shell_artillery_smoke_Base", _cfgAmmo]} || {_ammo isKindOf ["gm_shell_155mm_smoke_base", _cfgAmmo]}) then {continue};

    private _data = [_cfgName, getText (_x >> "displayName"), _ammo];

    if (_isHowitzer) then {_ordnanceHowitzer pushBack _data;};
    if (_isMortar) then {_ordnanceMortar pushBack _data;};
} forEach configProperties [configFile >> "CfgVehicles", "isClass _x && {getNumber (_x >> 'scopeCurator') == 2}"];

uiNamespace setVariable [QGVAR(howitzerShellsCache), [_ordnanceHowitzer, 1] call CBA_fnc_sortNestedArray];
uiNamespace setVariable [QGVAR(mortarShellsCache), [_ordnanceMortar, 1] call CBA_fnc_sortNestedArray];
