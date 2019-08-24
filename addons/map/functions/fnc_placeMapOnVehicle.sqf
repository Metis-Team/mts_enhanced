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
 *      2. ARRAY - Dir and up vectors of the map.
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
    ["_vectorDirAndUp", [[0,1,0],[0,0,1]], [[]]]
];

CHECK(!hasinterface);
CHECK(_vehClass isEqualTo "");

private _placeMapOnVehAction = [
    QGVAR(placeMapOnVehAction),
    LLSTRING(placeMap),
    "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\map_ca.paa",
    {
        params ["_vehicle", "", "_args"];
        _args params ["_offset", "_vectorDirAndUp"];

        player playAction "putdown";
        private _sound = format [QGVAR(unfoldSound_%1), ((floor random 4) + 1)];
        [player, [_sound, 300]] remoteExecCall ["say3D"];

        [{((animationState player) select [25,7]) isEqualTo "putdown"}, {
            params ["_vehicle", "_offset", "_vectorDirAndUp"];

            private _map = GVAR(itemMapClassname) createVehicle [0,0,0];
            _map attachTo [_vehicle, _offset];
            _map setVectorDirAndUp _vectorDirAndUp;

            _vehicle setVariable [QGVAR(isMapOnVehicle), true, true];

            [_map, _vehicle] remoteExecCall [QFUNC(mapActionMenu), 0, _map];

            player unlinkItem "ItemMap";
        }, [_vehicle, _offset, _vectorDirAndUp]] call CBA_fnc_waitUntilAndExecute;
    },
    {
        ("ItemMap" in (assignedItems player)) &&
        {[player, objNull] call ace_common_fnc_canInteractWith} &&
        {!(_target getVariable [QGVAR(isMapOnVehicle), false])}
    },
    {},
    [_offset, _vectorDirAndUp],
    _offset,
    2
] call ace_interact_menu_fnc_createAction;
[_vehClass, 0, [], _placeMapOnVehAction] call ace_interact_menu_fnc_addActionToClass;
