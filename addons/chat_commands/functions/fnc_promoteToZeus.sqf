#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Promotes someone to Zeus.
 *
 *  Parameter(s):
 *      0: STRING - Chat command arguments as string.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      ["", 1] call mts_chat_commands_fnc_promoteToZeus
 *
 */

params [["_name", "", [""]]];

private _unit = [_name] call FUNC(getTarget);
if (isNull _unit) exitWith {
    [{systemChat _this}, LLSTRING(noUnit)] call CBA_fnc_execNextFrame; // Next frame so the message is shown after command line
};

if (!isNull getAssignedCuratorLogic _unit) exitWith {};

[QGVAR(createZeus), [_unit]] call CBA_fnc_serverEvent;
