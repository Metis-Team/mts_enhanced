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
 *      3: CODE - Addtional condition when to show action
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

CHECK(!hasinterface || _vehClass isEqualTo "");

private _placeMapOnVehAction = [
    QGVAR(placeMapOnVehAction),
    LLSTRING(placeMap),
    "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\map_ca.paa",
    {
        params ["_vehicle", "_player", "_args"];
        _args params ["_offset", "_vectorDirAndUp"];

        _player playAction "putdown";
        [_player, "unfold"] call FUNC(playMapSound);

        [{((animationState (_this select 1)) select [25,7]) isEqualTo "putdown"}, {
            params ["_vehicle", "_player", "_offset", "_vectorDirAndUp"];

            private _map = GVAR(itemMapClassname) createVehicle [0,0,0];
            _map attachTo [_vehicle, _offset];
            _map setVectorDirAndUp _vectorDirAndUp;

            _vehicle setVariable [QGVAR(isMapOnVehicle), true, true];

            private _id = [QGVAR(addMapActions), [_map]] call CBA_fnc_globalEventJIP;
            [_id, _map] call CBA_fnc_removeGlobalEventJIP; // Remove JIP when map is deleted

            private _mapClass = [_player] call FUNC(removeMap);
            _map setVariable [QGVAR(mapClass), _mapClass, true];
        }, [_vehicle, _player, _offset, _vectorDirAndUp]] call CBA_fnc_waitUntilAndExecute;
    },
    {
        params ["_vehicle", "_player", "_args"];
        _args params ["", "", "_condition", "_conditionArgs"];

        ([_player] call FUNC(hasMap)) &&
        {[_player, _vehicle, ["isNotInside"]] call ace_common_fnc_canInteractWith} &&
        {!(_vehicle getVariable [QGVAR(isMapOnVehicle), false])} &&
        {[_vehicle, _player, _conditionArgs] call _condition}
    },
    {},
    [_offset, _vectorDirAndUp, _condition, _conditionArgs],
    _offset,
    2
] call ace_interact_menu_fnc_createAction;
[_vehClass, 0, [], _placeMapOnVehAction] call ace_interact_menu_fnc_addActionToClass;
