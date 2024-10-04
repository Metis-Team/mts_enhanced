#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Start the mine clearing process. Must be called where vehicle is local.
 *
 *  Parameter(s):
 *      0: OBJECT - Mine clearing vehicle (ABV/MiRPz)
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [_veh] call mts_engineer_fnc_startMineClearing
 *
 */

params [["_vehicle", objNull, [objNull]]];

CHECK(isNull _vehicle);
CHECKRET(!local _vehicle,ERROR_1("Called on non-local vehicle '%1'",_vehicle));

_vehicle setVariable [QGVAR(mineClearingActive), true, true];

// _vehicle allowDamage false;

_vehicle setCruiseControl [MAX_MINE_CLEARING_SPEED, false];

// Animate plow
private _animationSource = ["", 0];
if (_vehicle isKindOf "B_APC_Tracked_01_CRV_F") then {
    _animationSource = ["moveplow", 1]; // for vanilla
};
if (_vehicle isKindOf "gm_BPz2a0_base") then {
    _animationSource = ["dozer_blade_elev_source", 0.65]; // for gm
};

_vehicle animateSource _animationSource;

private _ehHandle = _vehicle addEventHandler ["HandleDamage", {
    params ["_vehicle", "_selection", "_damage", "_source", "_projectile"];

    TRACE_1("HandleDamage",_this);

    if (_projectile isEqualTo "") exitWith {nil};
    if (_damage < 0.01) exitWith {nil};

    if (
        (_projectile isKindOf "TimeBombCore") ||
        {_projectile isKindOf "DirectionalBombBase"} ||
        {_projectile isKindOf "BoundingMineBase"} ||
        {_projectile isKindOf "MineBase"} ||
        {_projectile isKindOf "PipeBombBase"}
    ) exitWith {
        TRACE_1("HandleDamage No damage",_projectile);
        0
    };

    nil
}];
_vehicle setVariable [QGVAR(mineClearingEHHandle), _ehHandle, true];

[{
    params ["_vehicle", "_animationSource"];
    _animationSource params ["_animationName", "_animationPhase"];

    (_vehicle animationSourcePhase _animationName) >= (_animationPhase - 0.02)
}, {
    params ["_vehicle"];

    [_vehicle] remoteExecCall [QFUNC(handleMineClearingEffects), 0];

    GVAR(lastDirtPatch) = objNull;

    [{
        params ["_PFHArgs", "_PFHID"];
        _PFHArgs params ["_vehicle", "_animationSource"];

        if (!(_vehicle getVariable [QGVAR(mineClearingActive), false])) exitWith {
            [_PFHID] call CBA_fnc_removePerFrameHandler;
        };

        if ((isNull GVAR(lastDirtPatch)) || (_vehicle distance GVAR(lastDirtPatch) > 2.5)) then {
            private _dirtPatch = createVehicle ["Land_DirtPatch_01_6x8_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
            private _dirtPatchPosASL = AGLToASL (_vehicle modelToWorldVisual [0, 2, 0]);
            _dirtPatch setPosASL _dirtPatchPosASL;
            _dirtPatch setDir (getDir _vehicle) + 90;

            createVehicle ["Land_ClutterCutter_medium_F", getPosATL _dirtPatch, [], 0, "CAN_COLLIDE"];

            GVAR(lastDirtPatch) = _dirtPatch;
        };
    }, DIRT_PATCH_UPDATE_INTERVAL, _this] call CBA_fnc_addPerFrameHandler;
}, [_vehicle, _animationSource]] call CBA_fnc_waitUntilAndExecute;
