/**
 *  Author: Timi007
 *
 *  Description:
 *      Sets group combat mode (engagement rules).
 *
 *  Parameter(s):
 *      0: STRING - Combat mode.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      ["BLUE"] call mts_zeus_fnc_setAICombatMode
 *
 */
#include "script_component.hpp"

params [["_combatMode", "", [""]]];
CHECK(_combatMode isEqualTo "");

//get selected groups
curatorSelected params ["", "_groups"];
CHECK(_groups isEqualTo []);

//set combat mode for each selected group
{
    [_x, _combatMode] remoteExecCall ["setCombatMode", groupOwner _x];
} forEach _groups;

//give the curator feedback
[localize format[LSTRING(AI_combatMode_%1), toLower(_combatMode)]] call zen_common_fnc_showMessage;
