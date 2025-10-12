#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Teleports unit to another unit.
 *
 *  Parameter(s):
 *      0: STRING - Chat command arguments as string.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [""] call mts_chat_commands_fnc_repair
 *
 */

params [["_names", "", [""]]];

private _units = [];

if (_names isEqualTo "") exitWith {systemChat LLSTRING(falseArgument)};

_names = _names splitString "~";
private _count = {
    _units pushBackUnique (_x call FUNC(parseNameToPlayer));
    true
} count _names;

if (objNull in _units) exitWith {systemChat LLSTRING(falseArgument)};

if (_count isEqualTo 1) then {
    _units = [player, _units select 0];
};

_units params ["_unitA"];
private _vehicle = objectParent _unitA;

if (!isNull _vehicle && {speed _vehicle > 1} && {((getPos _vehicle) select 2) > 2}) exitWith {
    systemChat LLSTRING(teleportError);
};
if (!isNull _vehicle) then {
    [_unitA, ["Eject", _vehicle]] remoteExecCall ["action", _unitA];
};

[{
    params ["_unitA", "_unitB"];

    private _vehicle = objectParent _unitB;
    if (isNull _vehicle) then {
        _unitA setDir (getDir _unitB);
        _unitA setPos (_unitB getRelPos [-1, 0]);
    } else {
        private _moveInAnyResult = _unitA moveInAny _vehicle;
        if (!_moveInAnyResult) exitWith {systemChat LLSTRING(teleportError)};
    };
}, _units, 0.5] call CBA_fnc_waitAndExecute;
