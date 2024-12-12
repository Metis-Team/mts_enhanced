#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Detonates given shell at detonation hight for airburst effect. Needs to be executed on the server.
 *
 *  Parameter(s):
 *      0: OBJECT - Artillery shell
 *      1: NUMBER - Detonation/airburst hight [m]
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      [_projectile, 15] call mts_zeus_fnc_artyAirburst
 *
 */

params ["_projectile", "_detonationHight"];

CHECK(!isServer);

TRACE_2("params",_projectile,_detonationHight);

[{
    params ["_argsArray", "_PFHID"];
    _argsArray params ["_projectile", "_detonationHight"];

    private _projectilePos = getPosATLVisual _projectile;
    if ((_projectilePos select 2) < _detonationHight) exitWith {
        TRACE_2("burst",_projectilePos,typeOf _projectile);
        deleteVehicle _projectile;
        "HelicopterExploSmall" createVehicle _projectilePos;

        // give projectile shrapnels
        [getPosASLVisual _projectile, typeOf _projectile] call ace_frag_fnc_frago;

        [_PFHID] call CBA_fnc_removePerFrameHandler;
    };
}, 0, _this] call CBA_fnc_addPerFrameHandler;
