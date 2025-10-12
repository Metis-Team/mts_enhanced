#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Promotes someone to an ACE medic or doctor.
 *
 *  Parameter(s):
 *      0: STRING - Chat command arguments as string.
 *      1: NUMBER - ACE medic class. 1: medic, 2: doctor
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      ["", 1] call mts_chat_commands_fnc_promoteToMedic
 *
 */

params [["_name", "", [""]], ["_medicClass", 1, [0]]];

private _unit = [_name] call FUNC(getTarget);
if (isNull _unit) exitWith {
    [{systemChat _this}, LLSTRING(noUnit)] call CBA_fnc_execNextFrame; // Next frame so the message is shown after command line
};

_unit setVariable ["ACE_medical_medicClass", _medicClass, true];
