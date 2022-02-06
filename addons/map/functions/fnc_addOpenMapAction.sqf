#include "script_component.hpp"
/**
 *  Author: PhILoX, Timi007
 *
 *  Description:
 *      Adds the open map actions to the placed map.
 *      This function has a local effect.
 *
 *  Parameter(s):
 *      0: OBJECT - Placed map
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [_map] call mts_map_fnc_addOpenMapAction
 *
 */

params [["_map", objNull, [objNull]]];
TRACE_1("call mts_map_fnc_addOpenMapAction", _map);

CHECK(!hasinterface || isNull _map);

TRACE_2("adding action", hasinterface, _map);

private _openMap = [
    QGVAR(openMap),
    LLSTRING(openMap),
    "A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\map_ca.paa",
    {
        params ["_map", "_player"];
        [_player, _map] call FUNC(openMap);
    },
    {
        params ["_map", "_player"];
        [_player, _map] call ace_common_fnc_canInteractWith
    }
] call ace_interact_menu_fnc_createAction;
[_map, 0, ["ACE_MainActions"], _openMap] call ace_interact_menu_fnc_addActionToObject;
