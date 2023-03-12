#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds an action for the object to pick it up (delete).
 *      This funtion has a local effect.
 *
 *  Parameter(s):
 *      0: OBJECT - Marker.
 *      1: OBJECT - Player picking up marker.
 *      2: ARRAY - Action args.
 *          0: STRING - Marker item classname.
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      [_marker, player, ["mts_items_marker_yellow"]] call mts_items_fnc_pickupMarker
 *
 */

params [["_marker", objNull, [objNull]], ["_player", objNull, [objNull]], ["_args", [""], [[]]]];
_args params ["_item"];
TRACE_3("Pickup marker",_player,_marker,_itemName);

CHECK(isNull _marker);

[_player, "PutDown"] call ace_common_fnc_doGesture;

[{
    params ["_marker", "_player", "_item"];

    [_player, _item] call ace_common_fnc_addToInventory;
    deleteVehicle _marker;
}, [_marker, _player, _item], 0.7] call CBA_fnc_waitAndExecute;
