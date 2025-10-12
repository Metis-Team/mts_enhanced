#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Returns the target unit to execute the chat command for.
 *
 *  Parameter(s):
 *      0: STRING - Empty string for player.
 *                  'getname', '-', or 'cursor' for cursor target
 *                  Ingame player name for other players.
 *
 *  Returns:
 *      OBJECT - Target unit to execute the chat command for or objNull if not found.
 *
 *  Example:
 *      [""] call mts_chat_commands_fnc_getTarget
 *      ["-"] call mts_chat_commands_fnc_getTarget
 *      ["John Doe"] call mts_chat_commands_fnc_getTarget
 *
 */

params [["_name", "", [""]]];

switch (toLower _name) do {
    case "": {
        player
    };
    case "getname";     // fallthrough
    case "-";           // fallthrough
    case "cursor": {
        private _cursorObject = cursorObject;
        [objNull, _cursorObject] select (_cursorObject isKindOf "Man")
    };
    default {
        [_name] call FUNC(parseNameToPlayer)
    };
}
