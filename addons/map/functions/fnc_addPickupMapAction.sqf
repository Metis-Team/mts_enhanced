#include "script_component.hpp"
/**
 *  Author: PhILoX, Timi007
 *
 *  Description:
 *      Adds the pickup map actions to the placed map.
 *      This function has a local effect.
 *
 *  Parameter(s):
 *      0: OBJECT - Placed map
 *      1: OBJECT - The vehicle which the map is placed on. (Optional, only needed if map was placed on vehicle)
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [_map] call mts_map_fnc_addPickupMapAction
 *
 */

params [["_map", objNull, [objNull]], ["_vehicle", objNull, [objNull]]];
TRACE_2("call mts_map_fnc_addOpenMapAction", _map, _vehicle);

CHECK(!hasinterface || isNull _map);

TRACE_2("adding action", hasinterface, _map);

private _pickupMap = [
    QGVAR(pickupMap),
    LLSTRING(pickupMap),
    "A3\Ui_f\data\IGUI\Cfg\Actions\take_ca.paa",
    {
        params ["_map", "_player", "_args"];
        _args params ["_vehicle"];

        [_player, _map, _vehicle] call FUNC(pickupMap);
    },
    {
        params ["_map", "_player"];
        !([_player] call FUNC(hasMap)) && {[_player, _map] call ace_common_fnc_canInteractWith}
    },
    {},
    [_vehicle]
] call ace_interact_menu_fnc_createAction;
[_map, 0, ["ACE_MainActions"], _pickupMap] call ace_interact_menu_fnc_addActionToObject;
