#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Checks if the given unit sees a bush in front of him. Returns the bush if available.
 *
 *  Parameter(s):
 *      0: OBJECT - Unit.
 *      1: NUMBER - Max distance to search for bushes.
 *
 *  Returns:
 *      OBJECT - Bush that the given unit sees or objNull if there is no bush.
 *
 *  Example:
 *      [player] call mts_common_fnc_seesBush;
 *
 */

params ["_player", ["_maxDistance", 5, [0]]];

private _startPosASL = eyePos _player;
private _endPosASL = _startPosASL vectoradd (getCameraViewDirection _player vectorMultiply _maxDistance);

private _intersections = lineIntersectsSurfaces [_startPosASL, _endPosASL, _player, objNull, true, 1, "VIEW"];

if (_intersections isEqualTo []) exitWith {objNull};

(_intersections select 0) params ["_bushPosASL", "", "_bush", "_parentObject"];

// Not a bush but maybe ground
if (isNull _bush && isNull _parentObject) exitWith {objNull};

// If is not a bush, exit
if (nearestTerrainObjects [_bush, ["Bush"], 0] isEqualTo []) exitWith {objNull};

_bush
