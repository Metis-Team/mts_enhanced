#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds the chat commands based on the CBA settings.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      call mts_chat_commands_fnc_compileCommands
 *
 */

if (!hasInterface) exitWith {};

{
    _x params ["_command", "_statement", "_args"];

    private _availableFor = [format [QGVAR(%1), _command]] call CBA_settings_fnc_get;
    if (isNil "_availableFor" || {_availableFor isEqualTo "disabled"}) then {
        continue;
    };

    [_command, {
        _thisArgs params ["_statement", "_args"];
        (_this + [_args]) call _statement
    }, _availableFor, [_statement, _args]] call CBA_fnc_registerChatCommand;
} forEach GVAR(commands);
