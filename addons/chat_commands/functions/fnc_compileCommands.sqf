#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Gathers all commands specified in the config and compiles them for later use.
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

private _cfgCommands = configFile >> QUOTE(ADDON);

private _commands = [];
{
    private _entryConfig = _x;

    private _command = configName _entryConfig;
    private _statement = compile getText (_entryConfig >> "statement");
    private _args = [_entryConfig, "args", []] call BIS_fnc_returnConfigEntry;

    private _commandEntry = [
        _command,
        _statement,
        _args
    ];

    _commands pushBack _commandEntry;
} forEach configProperties [_cfgCommands, "isClass _x", true];


missionNamespace setVariable [QGVAR(commands), _commands];
