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
 *      [_projectile, 15] call mts_zeus_fnc_artyAirburst
 *
 */
#include "script_component.hpp"

params ["_projectile", "_detonationHight"];

[{
    params ["_argsArray", "_PFHID"];
    _argsArray params ["_projectile", "_detonationHight"];

    if (((getPosATL _projectile) select 2) < _detonationHight) then {
        if (isServer) then {
            //give projectile shrapnels
            [getPosATL _projectile, velocity _projectile, "Sh_155mm_AMOS"] call ace_frag_fnc_frago;
        };
        _projectile setvelocity [0,0,0];
        "HelicopterExploSmall" createVehicle (getPosATL _projectile);
        deleteVehicle _projectile;

        [_PFHID] call CBA_fnc_removePerFrameHandler;
    };
}, 0, [_projectile, _detonationHight]] call CBA_fnc_addPerFrameHandler;
