#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Executes the artillery fire mission.
 *
 *  Parameter(s):
 *      0: ARRAY - Target area which includes logic / helper object to determine center pos and angle; length and width.
 *      1: STRING - Class of artillery shell.
 *      2: NUMBER - Hight above ground for shell detonation/airburst [m] (optional, default: 0)
 *      3: NUMBER - Simulated number of units firing.
 *      4: NUMBER - Number of shots per unit.
 *      5: BOOLEAN - Is duration being used? (or delay). (optional, default: false (delay active))
 *      6: NUMBER - Delay between shell in seconds (25% inaccuracy). If parameter 3 is true than it's the duration of the fire mission (optional, default: 1)
 *      7: NUMBER - Time on target in seconds. (optional, default: immediately)
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      [[_logic, 200, 100], "Sh_155mm_AMOS", 0, 3, 2, false, 5, 60] call mts_zeus_fnc_execFireMission
 *
 */

if (!isServer) exitWith {
    [QGVAR(execFireMission), _this] call CBA_fnc_serverEvent;
};

(_this select 0) params [
    ["_targetLogic", objNull, [objNull]],
    ["_areaWidth", 0, [0]],
    ["_areaDepth", 0, [0]]
];

// Simulate artillery shell queue
private _args = +_this;
_args set [0, [_areaWidth, _areaDepth]];
private _shellReverseQueue = _args call FUNC(calcArtyShellQueue);
if (_shellReverseQueue isEqualTo []) exitWith {ERROR("Empty artillery shell spawn queue.")};

// Begin fire mission
private _t0 = CBA_missionTime;
[QGVAR(fireMissionBegin), _this] call CBA_fnc_globalEvent;
TRACE_2("Begin fire mission",_t0,count _shellReverseQueue);

// Report splash 5 seconds before first impact if time on target is greater 10 seconds
private _firstImpactDelay = ((_shellReverseQueue select -1) select 0) - 5;
if (_firstImpactDelay > 5) then {
    [{
        params ["_targetLogic"];

        // Fire mission was deleted
        if (isNull _targetLogic) exitWith {};

        [QGVAR(fireMissionImpact), [_targetLogic]] call CBA_fnc_globalEvent;
    }, [_targetLogic], _firstImpactDelay] call CBA_fnc_waitAndExecute;
};

// Beginn fire for effect
[{
    params ["_args", "_handle"];
    _args params ["_targetLogic", "_t0", "_shellReverseQueue"];

    if (_shellReverseQueue isEqualTo [] || isNull _targetLogic) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;

        if (!isNull _targetLogic) then {
            LOG("Fire mission completed normally.");
            _targetLogic setVariable [QGVAR(fireMissionComplete), true, true];
            deleteVehicle _targetLogic; // Will trigger deleted EH and broadcast complete event
        };
    };

    private _targetLogicPosATL = getPosATL _targetLogic;
    private _targetLogicDir = getDirVisual _targetLogic;
    private _indexesToDelete = [];

    {
        _x params ["_delay", "_ammoType", "_offsetATL", "_velocity", "_detonationHight"];

        if ((_t0 + _delay) > CBA_missionTime) then {
            break;
        };

        private _rotatedOffsetATL = [_offsetATL, -_targetLogicDir] call BIS_fnc_rotateVector2D;
        private _posATL = _targetLogicPosATL vectorAdd _rotatedOffsetATL;
        private _projectile = createVehicle [_ammoType, _posATL, [], 0, "CAN_COLLIDE"];
        _projectile setVelocity _velocity;

        if (_detonationHight > 0) then {
            [_projectile, _detonationHight] call FUNC(waitAndExecAirburst);
        };

        _indexesToDelete pushBack _forEachIndex;
    } forEachReversed _shellReverseQueue;

    _shellReverseQueue deleteAt _indexesToDelete;
}, 0, [_targetLogic, _t0, _shellReverseQueue]] call CBA_fnc_addPerFrameHandler;
