#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Turns the drone unit into a suicide drone. Must be executed where unit is local.
 *
 *  Parameter(s):
 *      0: OBJECT - Unit that should get turned into a suicide drone.
 *      1: STRING - Vehicle classname of the charge which explodes when the drone is destroyed.
 *      2: NUMBER - Maximum ATL height where the charge does not detonate, even when the drone is destroyed.
 *                  Negative number do not set max height. (Default: No max height.)
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [_unit, "DemoCharge_Remote_Ammo_Scripted"] call mts_zeus_fnc_makeIntoSuicideDrone
 *
 */

params [["_unit", objNull, [objNull]], ["_chargeType", "", [""]], ["_maxTriggerHeight", -1, [0]]];
TRACE_2("makeIntoSuicideDrone",_unit,_chargeType);

if (isNull _unit || _chargeType isEqualTo "") exitWith {};
if (!local _unit) exitWith {};
if (_unit getVariable [QGVAR(isSuicideDrone), false]) exitWith {};

[_unit, "Killed", {
    _thisArgs params ["_unit", "_chargeType", "_maxTriggerHeight"];

    private _posATL = getPosATLVisual _unit;
    if ((_posATL select 2) <= _maxTriggerHeight || _maxTriggerHeight < 0) then {
        private _charge = createVehicle [_chargeType, _posATL, [], 0, "CAN_COLLIDE"];
        _charge setDamage 1;
    };

    _unit removeEventHandler [_thisType, _thisId];
}, [_unit, _chargeType, _maxTriggerHeight]] call CBA_fnc_addBISEventHandler;

_unit setVariable [QGVAR(isSuicideDrone), true, true];
