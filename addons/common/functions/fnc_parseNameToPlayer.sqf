/**
 *  Author: PhILoX
 *
 *  Description:
 *      parses player name to player objekt
 *
 *  Parameter(s):
 *      0: STRING - Player name
 *
 *  Returns:
 *      OBJECT - Player object | ObjNull if not found
 *
 *  Example:
 *      ["John Doe"] call mts_common_fnc_parseNameToPlayer
 *
 */
#include "script_component.hpp"

params [["_name", "", [""]]];
private _unit = objNull;

_name = toLower _name;

_unit = {
    if (toLower name _x isEqualTo _name) exitWith {_x};
} forEach (call CBA_fnc_players);

_unit
