#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Disables/Enables the AI’s movement and the target alignment or only the movement.
 *
 *  Parameter(s):
 *      0: STRING - Section to disable/enable.
 *      1: BOOLEAN - Enable/Disable.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      ["path", true] call mts_zeus_fnc_switchAIPathBehaviour
 *
 */

params [["_section", "", [""]], ["_enableAI", true, [true]]];

CHECK(_section isEqualTo "");

//get selected objects
curatorSelected params ["_objects"];

//enable/disable movement for each selected unit
{
    CHECK((isPlayer _x) || {(count (crew _x)) isEqualTo 0} || {isnull _x});
    if (_enableAI) then {
        [_x, _section] remoteExecCall ["enableAI", _x];
    } else {
        [_x, _section] remoteExecCall ["disableAI", _x];
    };
} forEach _objects;

//give the curator feedback
[localize format[LSTRING(AI_pathBehaviour_%1_%2), _section, _enableAI]] call zen_common_fnc_showMessage;
