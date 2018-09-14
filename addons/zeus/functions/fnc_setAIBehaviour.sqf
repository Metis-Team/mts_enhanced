/**
 *  Author: Timi007
 *
 *  Description:
 *      Sets group behaviour mode.
 *
 *  Parameter(s):
 *      0: STRING - Behaviour.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      ["CARELESS"] call mts_zeus_fnc_setAIBehaviour
 *
 */
#include "script_component.hpp"

params [["_behaviour", "", [""]]];
CHECK(_behaviour isEqualTo "");

//get selected groups
curatorSelected params ["", "_groups"];
CHECK(_groups isEqualTo []);

//set behaviour for each selected group
{
    _x setBehaviour _behaviour;
} count _groups;

//give the curator feedback
[localize format[LSTRING(AI_behaviour_%1), tolower(_behaviour)]] call Ares_fnc_ShowZeusMessage;
