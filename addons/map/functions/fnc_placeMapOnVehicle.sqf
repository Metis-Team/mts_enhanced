#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds an action to place a unit's map on the vehicle.
 *      The map will be attached to the vehicle with the given offset and orientation.
 *      This function has a local effect.
 *
 *  Parameter(s):
 *      0: STRING - Classname of (typeOf) the vehicle.
 *      1: ARRAY - Offset of map to the vehicle.
 *      2: ARRAY - Dir and up vectors of the map.
 *      3: CODE - Additional condition when to show action
 *          Passed arguments:
 *          0: OBJECT - Vehicle.
 *          1: OBJECT - Player.
 *          2: ARRAY - Custom args (see param 4)).
 *      4: ARRAY - Custom arguments for the condition.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [(typeOf veh_wolf_1), [-0.205078,1.49292,-0.3325], [[-1,0,0],[0,0.1,1]]] call mts_map_fnc_placeMapOnVehicle
 *
 */

params [
    ["_vehClass", "", [""]],
    ["_offset", [0,0,0], [[]]],
    ["_vectorDirAndUp", [[0,1,0],[0,0,1]], [[]]],
    ["_condition", {true}, [{}]],
    ["_conditionArgs", [], [[]]]
];

CHECK(!hasInterface || _vehClass isEqualTo "");

private _placeMapOnVehAction = [_offset, _vectorDirAndUp, _condition, _conditionArgs] call FUNC(getPlaceMapOnVehicleAction);
[_vehClass, 0, [], _placeMapOnVehAction] call ace_interact_menu_fnc_addActionToClass;
