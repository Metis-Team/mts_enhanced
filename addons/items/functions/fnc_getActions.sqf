#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Gets the child actions for placing markers.
 *
 *  Parameter(s):
 *      0: OBJECT - Player.
 *
 *  Returns:
 *      ARRAY - Actions.
 *
 *  Example:
 *      [player] call mts_items_fnc_getActions
 *
 */

params ["_player"];

private _actions = [];

{
    (GVAR(markerCache) get _x) params ["_vehicle", "_displayName", "_icon"];

    _actions pushBack [
        [
            _x,
            _displayName,
            _icon,
            {[_this select 0, _this select 2] call FUNC(placeMarker)},
            {true},
            {},
            _x
        ] call ace_interact_menu_fnc_createAction,
        [],
        _player
    ];
} forEach ([_player] call FUNC(getMarkers));

_actions
