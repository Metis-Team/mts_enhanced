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
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [_map] call mts_map_fnc_addPickupMapAction
 *
 */

params [["_map", objNull, [objNull]]];

CHECK(!hasInterface || isNull _map);

private _pickupMap = [
    QGVAR(pickupMap),
    LLSTRING(pickupMap),
    "A3\Ui_f\data\IGUI\Cfg\Actions\take_ca.paa",
    {
        params ["_map", "_player"];
        [_player, _map] call FUNC(pickupMap);
    },
    {
        params ["_map", "_player"];
        !([_player] call FUNC(hasMap)) && {[_player, _map] call ace_common_fnc_canInteractWith}
    }
] call ace_interact_menu_fnc_createAction;
[_map, 0, ["ACE_MainActions"], _pickupMap] call ace_interact_menu_fnc_addActionToObject;
