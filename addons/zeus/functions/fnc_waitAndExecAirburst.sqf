#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Detonates given shell at detonation hight for airburst effect.
 *
 *  Parameter(s):
 *      0: OBJECT - Artillery shell
 *      1: NUMBER - Detonation/airburst hight [m]
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      [_projectile, 15] call mts_zeus_fnc_waitAndExecAirburst
 *
 */

if (!isServer) exitWith {
    [QGVAR(waitAndExecAirburst), _this] call CBA_fnc_serverEvent;
};
TRACE_1("params",_this);

[{
    params ["_projectile", "_detonationHight"];

    ((getPosATLVisual _projectile) select 2) < _detonationHight
}, {
    params ["_projectile", "_detonationHight"];

    private _projectilePosASL = getPosASLVisual _projectile;
    private _projectileType = typeOf _projectile;
    TRACE_2("burst",_projectilePosASL,_projectileType);

    deleteVehicle _projectile;
    createVehicle ["HelicopterExploSmall", ASLToATL _projectilePosASL, [], 0, "CAN_COLLIDE"];

    // Wait a frame to make sure it doesn't target the dead
    [ace_frag_fnc_frago, [_projectilePosASL, _projectileType]] call CBA_fnc_execNextFrame;
}, _this] call CBA_fnc_waitUntilAndExecute;
