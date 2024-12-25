#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Executes the artillery fire mission.
 *
 *  Parameter(s):
 *      0: ARRAY - Center position of the impact area (2D or 3D; z makes no difference)
 *      1: STRING - Class of artillery shell
 *      2: NUMBER - Total amount of artillery shell which will be fired
 *      3: BOOLEAN - Is duration being used? (or delay). (optional, default: false (delay active))
 *      4: NUMBER - Delay between shell in seconds (25% inaccuracy). If parameter 3 is true than it's the duration of the fire mission (optional, default: 1)
 *      5: NUMBER - Hight above ground for shell detonation/airburst [m] (optional, default: 0)
 *      6: ARRAY - Area where the shells should land. Format: [length [m] <NUMBER>, width [m] <NUMBER>, angle [°] <NUMBER>] (optional, default: parameter 0)
 *      7: NUMBER - Time on target in seconds. (optional, default: immediately)
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      [[400,500], "Sh_155mm_AMOS", 5, false, 1, 0, [200,100,25], 5] call mts_zeus_fnc_execArtyStrike
 *
 */

params ["_centerPos"];

private _group = createGroup [sideLogic, true];
private _targetLogic = _group createUnit [QGVAR(moduleArtyTarget), [0, 0, 0], [], 0, "CAN_COLLIDE"];
_targetLogic setPosATL _centerPos;
[zen_position_logics_fnc_add, [_targetLogic, "Metis Artillery Target"]] call CBA_fnc_execNextFrame;

private _shellReverseQueue = _this call FUNC(calcArtyShellQueue);
private _t0 = CBA_missionTime;
TRACE_3("Begin fire mission",_t0,count _shellReverseQueue,_shellReverseQueue);

[{
    params ["_args", "_handle"];
    _args params ["_t0", "_shellReverseQueue", "_targetLogic"];

    if (_shellReverseQueue isEqualTo [] || isNull _targetLogic) exitWith {
        LOG("Fire mission complete.");
        [_handle] call CBA_fnc_removePerFrameHandler;

        deleteVehicle _targetLogic;
    };

    private _indexesToDelete = [];
    {
        _x params ["_delay", "_ammoType", "_posATL", "_velocity", "_detonationHight"];

        if ((_t0 + _delay) > CBA_missionTime) then {
            break;
        };

        private _projectile = createVehicle [_ammoType, _posATL, [], 0, "CAN_COLLIDE"];
        _projectile setVelocity _velocity;

        if (_detonationHight > 0) then {
            [_projectile, _detonationHight] call FUNC(waitAndExecAirburst);
        };

        _indexesToDelete pushBack _forEachIndex;
    } forEachReversed _shellReverseQueue;

    _shellReverseQueue deleteAt _indexesToDelete;
}, 0, [_t0, _shellReverseQueue, _targetLogic]] call CBA_fnc_addPerFrameHandler;
