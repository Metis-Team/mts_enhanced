#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Heal given player.
 *
 *  Parameter(s):
 *      0: STRING - Chat command arguments as string.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [""] call mts_chat_commands_fnc_heal
 *
 */

params [["_name", "", [""]]];

private _unit = [_name] call FUNC(getTarget);
if (isNull _unit) exitWith {
    [{systemChat _this}, LLSTRING(noUnit)] call CBA_fnc_execNextFrame;
};

["ace_medical_treatment_fullHealLocal", _unit, _unit] call CBA_fnc_targetEvent;
