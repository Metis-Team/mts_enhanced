#include "script_component.hpp"
/**
 *  Author: PhILoX, Timi007
 *
 *  Description:
 *      Parses player name to player object.
 *
 *  Parameter(s):
 *      0: STRING - Player name.
 *
 *  Returns:
 *      OBJECT - Player object or objNull if not found.
 *
 *  Example:
 *      ["John Doe"] call mts_chat_commands_fnc_parseNameToPlayer
 *
 */

params [["_name", "", [""]]];

if (_name isEqualTo "") exitWith {objNull};
_name = toLower _name;

private _allPlayers = call CBA_fnc_players;
private _index = _allPlayers findIf {toLower name _x isEqualTo _name};

if (_index >= 0) then {
    _allPlayers select _index
} else {
    objNull
}
