/**
 *  Author: Timi007
 *
 *  Description:
 *      Sets an AI/AI group selected by the zeus to a given stance.
 *
 *  Parameter(s):
 *      0: STRING - Stance.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      ["DOWN"] call mts_zeus_fnc_setAIStance
 *
 */
#include "script_component.hpp"

params [["_stance", "", [""]]];
CHECK(_stance isEqualTo "");

//get selected object
curatorSelected params ["_objects"];

//set stance for each selected unit
{
    CHECK((isPlayer _x) || {(count (crew _x)) isEqualTo 0} || {isnull _x});
    [_x, _stance] remoteExecCall ["setUnitPos", _x];
} forEach _objects;
