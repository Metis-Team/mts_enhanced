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

[{
    params ["_argsArray", "_PFHID"];
    _argsArray params ["_projectile", "_detonationHight"];

    private _projectilePos = getPosATL _projectile;
    if ((_projectilePos select 2) < _detonationHight) exitWith {
        // give projectile shrapnels
        [_projectilePos, velocity _projectile, "Sh_155mm_AMOS"] call ace_frag_fnc_frago;

        _projectile setVelocity [0,0,0];
        "HelicopterExploSmall" createVehicle _projectilePos;
        deleteVehicle _projectile;

        [_PFHID] call CBA_fnc_removePerFrameHandler;
    };
}, 0, _this] call CBA_fnc_addPerFrameHandler;
