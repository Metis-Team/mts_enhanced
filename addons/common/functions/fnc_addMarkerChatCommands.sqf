#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Add chat commands to save and load map markers
 *
 *  Parameter(s):
 *      None
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      call mts_common_fnc_addMarkerChatCommands
 *
 */

if (!hasInterface) exitWith {};

["markers", {
    TRACE_1("Chat command marker",_this);
    params ["_command"];
    (_command splitString " ") params [["_operation", ""], ["_namespaceName", "profile"]];

    private _namespace = switch (toLower _namespaceName) do {
        case "game": {uiNamespace};
        case "mission": {localNamespace};
        case "profile": {profileNamespace};
        default {
            WARNING_1("Invalid namespace name: '%1'. Using profile namespace.",_namespaceName);
            _namespaceName = "profile";
            profileNamespace
        };
    };

    switch (toLower _operation) do {
        case "save": {
            [_namespace] call FUNC(saveMarkers);
            [{systemChat _this}, format [LLSTRING(chatCommands_savedMarkers), _namespaceName]] call CBA_fnc_execNextFrame; // Next frame so the message is shown after command line
        };
        case "load": {
            private _worldName = _namespace getVariable [QGVAR(savedMarkersWorldName), ""];

            if (_worldName isEqualTo "") exitWith {
                [{systemChat _this}, format [LLSTRING(chatCommands_noMarkersSaved), _namespaceName]] call CBA_fnc_execNextFrame;
            };

            if (_worldName != worldName) exitWith {
                [{systemChat _this}, format [LLSTRING(chatCommands_wrongWorld), _worldName]] call CBA_fnc_execNextFrame;
            };

            [_namespace] call FUNC(loadMarkers);
            [{systemChat _this}, format [LLSTRING(chatCommands_loadedMarkers), _namespaceName]] call CBA_fnc_execNextFrame;
        };
        case "deletesave": {
            _namespace setVariable [QGVAR(savedMarkersWorldName), nil];
            _namespace setVariable [QGVAR(savedMarkers), nil];

            if (_namespace isEqualTo profileNamespace) then {saveProfileNamespace};
            [{systemChat _this}, format [LLSTRING(chatCommands_deletedSavedMarkers), _namespaceName]] call CBA_fnc_execNextFrame;
        };
        default {
            WARNING_1("Invalid command: '%1'",_operation);
            [{systemChat _this}, format [LLSTRING(chatCommands_invalidMarkerCommand), "save, load, deletesave"]] call CBA_fnc_execNextFrame;
        };
    };
}, "adminLogged"] call CBA_fnc_registerChatCommand;
