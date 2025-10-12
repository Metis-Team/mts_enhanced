#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Promotes someone to an ACE engineer.
 *
 *  Parameter(s):
 *      0: STRING - Chat command arguments as string.
 *      1: NUMBER - ACE engineer class. 1: engineer, 2: advanced engineer
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      ["", 1] call mts_chat_commands_fnc_promoteToEng
 *
 */

params [["_name", "", [""]], ["_engClass", 1, [0]]];

private _unit = [_name] call FUNC(getTarget);
if (isNull _unit) exitWith {
    [{systemChat _this}, LLSTRING(noUnit)] call CBA_fnc_execNextFrame; // Next frame so the message is shown after command line
};

_unit setVariable ["ACE_isEngineer", _engClass, true];
