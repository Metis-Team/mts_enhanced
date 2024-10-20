#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Starts the placing process of the marker for the player.
 *      Markers can be placed with the special marker items.
 *
 *  Parameter(s):
 *      0: OBJECT - Player.
 *      1: STRING - Marker item.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [player, "mts_items_marker_yellow"] call mts_items_fnc_placeMarker
 *
 */

params [["_player", objNull, [objNull]], ["_item", "", [""]]];
TRACE_2("Placing marker",_player,_item);

CHECK(_item isEqualTo "");

(GVAR(markerCache) get _item) params ["_vehicleClass", "_displayName"];

private _marker = _vehicleClass createVehicle [0, 0, 0];

TRACE_1("Created marker",_marker);

// Set marker start height
GVAR(objectHeight) = MAX_HEIGHT;

GVAR(isPlacing) = PLACE_WAITING;

// Add info dialog for the player which show the controls
private _placeMarkerText = format [LLSTRING(placeMarker), _displayName];
[_placeMarkerText, LLSTRING(cancel), LLSTRING(adjustHeight)] call ace_interaction_fnc_showMouseHint;

private _mouseClickID = [_player, "DefaultAction", {
    GVAR(isPlacing) isEqualTo PLACE_WAITING
}, {
    GVAR(isPlacing) = PLACE_APPROVE
}] call ace_common_fnc_addActionEventHandler;

[{ // Start of PFH
    params ["_args", "_handle"];
    _args params ["_player", "_item", "_marker", "_mouseClickID"];

    if (isNull _marker || {!([_player, _marker] call ace_common_fnc_canInteractWith)}) then {
        GVAR(isPlacing) = PLACE_CANCEL;
    };

    if (GVAR(isPlacing) isNotEqualTo PLACE_WAITING) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
        call ace_interaction_fnc_hideMouseHint;
        [_player, "DefaultAction", _mouseClickID] call ace_common_fnc_removeActionEventHandler;

        if (GVAR(isPlacing) isEqualTo PLACE_APPROVE) then {
            // End position of the marker

            GVAR(isPlacing) = PLACE_CANCEL;

            [_player, "PutDown"] call ace_common_fnc_doGesture;

            _player removeItem _item;

            [QGVAR(placed), [_player, _marker, _item]] call CBA_fnc_localEvent;
        } else {
            // Action is canceled
            deleteVehicle _marker;
        };
    };

    private _pos = ((eyePos _player) vectorAdd ((getCameraViewDirection _player) vectorMultiply MARKER_PLACING_DISTANCE));
    // Adjust height of marker with the scroll wheel
    _pos set [2, ((getPosWorld _player) select 2) + GVAR(objectHeight)];

    _marker setPosWorld _pos;
    _marker setDir (getDir _player);
}, 0, [_player, _item, _marker, _mouseClickID]] call CBA_fnc_addPerFrameHandler;
