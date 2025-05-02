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

// Last created markers
GVAR(createdMarkers) = [];

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

    private _saveNamespace = false;

    switch (toLower _operation) do {
        case "save": {
            private _markers = [] call FUNC(getMarkers);

            _namespace setVariable [QGVAR(savedMarkersWorldName), worldName];
            _namespace setVariable [QGVAR(savedMarkers), _markers];
            _saveNamespace = true;

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

            private _markers = _namespace getVariable [QGVAR(savedMarkers), []];
            GVAR(createdMarkers) = [_markers] call FUNC(createMarkers);

            [{systemChat _this}, format [LLSTRING(chatCommands_loadedMarkers), _namespaceName]] call CBA_fnc_execNextFrame;
        };

        case "undo": {
            if (GVAR(createdMarkers) isEqualTo []) exitWith {
                [{systemChat _this}, LLSTRING(chatCommands_noMarkersToUndo)] call CBA_fnc_execNextFrame;
            };

            {
                deleteMarker _x;
            } forEach GVAR(createdMarkers);

            GVAR(createdMarkers) = [];

            [{systemChat _this}, LLSTRING(chatCommands_undoMarkers)] call CBA_fnc_execNextFrame;
        };

        case "deletesave": {
            _namespace setVariable [QGVAR(savedMarkersWorldName), nil];
            _namespace setVariable [QGVAR(savedMarkers), nil];
            _saveNamespace = true;

            [{systemChat _this}, format [LLSTRING(chatCommands_deletedSavedMarkers), _namespaceName]] call CBA_fnc_execNextFrame;
        };

        default {
            WARNING_1("Invalid command: '%1'",_operation);
            [{systemChat _this}, format [LLSTRING(chatCommands_invalidMarkerCommand), "#markers save / load / undo / deletesave"]] call CBA_fnc_execNextFrame;
        };
    };

    if (_saveNamespace) then {
        if (_namespace isEqualTo profileNamespace) then {saveProfileNamespace};
        if (_namespace isEqualTo missionProfileNamespace) then {saveMissionProfileNamespace};
    };
}, "adminLogged"] call CBA_fnc_registerChatCommand;
