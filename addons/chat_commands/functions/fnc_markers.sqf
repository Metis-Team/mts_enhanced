#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Chat sub commands to save and load map markers.
 *
 *  Parameter(s):
 *      0: STRING - Chat command arguments as string.
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      ["save"] call mts_chat_commands_fnc_markers
 *
 */

params [["_command", "", [""]]];
TRACE_1("Chat command marker",_this);

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
        private _markers = [] call EFUNC(common,getMarkers);
        private _mtsMarkers = [] call EFUNC(common,getMtsMarkers);

        _namespace setVariable [QGVAR(savedMarkersWorldName), worldName];
        _namespace setVariable [QGVAR(savedMarkers), _markers];
        _namespace setVariable [QGVAR(savedMtsMarkers), _mtsMarkers];
        _saveNamespace = true;

        [{systemChat _this}, format [LLSTRING(savedMarkers), _namespaceName]] call CBA_fnc_execNextFrame; // Next frame so the message is shown after command line
    };

    case "load": {
        private _worldName = _namespace getVariable [QGVAR(savedMarkersWorldName), ""];

        if (_worldName isEqualTo "") exitWith {
            [{systemChat _this}, format [LLSTRING(noMarkersSaved), _namespaceName]] call CBA_fnc_execNextFrame;
        };

        if (_worldName != worldName) exitWith {
            [{systemChat _this}, format [LLSTRING(wrongWorld), _worldName]] call CBA_fnc_execNextFrame;
        };

        private _markers = _namespace getVariable [QGVAR(savedMarkers), []];
        GVAR(createdMarkers) = [_markers] call EFUNC(common,createMarkers);

        private _mtsMarkers = _namespace getVariable [QGVAR(savedMtsMarkers), []];
        GVAR(createdMtsMarkers) = [_mtsMarkers] call EFUNC(common,createMtsMarkers);

        [{systemChat _this}, format [LLSTRING(loadedMarkers), _namespaceName]] call CBA_fnc_execNextFrame;
    };

    case "undo": {
        if (GVAR(createdMarkers) isEqualTo [] && GVAR(createdMtsMarkers) isEqualTo []) exitWith {
            [{systemChat _this}, LLSTRING(noMarkersToUndo)] call CBA_fnc_execNextFrame;
        };

        {
            deleteMarker _x;
        } forEach GVAR(createdMarkers);
        GVAR(createdMarkers) = [];

        if (["mts_markers"] call EFUNC(common,isModLoaded)) then {
            {
                [_x] call mts_markers_fnc_deleteMarker;
            } forEach GVAR(createdMtsMarkers);
        };
        GVAR(createdMtsMarkers) = [];

        [{systemChat _this}, LLSTRING(undoMarkers)] call CBA_fnc_execNextFrame;
    };

    case "deletesave": {
        _namespace setVariable [QGVAR(savedMarkersWorldName), nil];
        _namespace setVariable [QGVAR(savedMarkers), nil];
        _namespace setVariable [QGVAR(savedMtsMarkers), nil];
        _saveNamespace = true;

        [{systemChat _this}, format [LLSTRING(deletedSavedMarkers), _namespaceName]] call CBA_fnc_execNextFrame;
    };

    default {
        WARNING_1("Invalid command: '%1'",_operation);
        [{systemChat _this}, format [LLSTRING(invalidMarkerCommand), "#markers save / load / undo / deletesave"]] call CBA_fnc_execNextFrame;
    };
};

if (_saveNamespace) then {
    if (_namespace isEqualTo profileNamespace) then {saveProfileNamespace};
    if (_namespace isEqualTo missionProfileNamespace) then {saveMissionProfileNamespace};
};
