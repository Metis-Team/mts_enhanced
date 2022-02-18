#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Picks up the map object and adds it to the players inventory.
 *
 *  Parameter(s):
 *      0: OBJECT - Player which takes the map from the ground.
 *      1: OBJECT - The map object to pickup.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [player, cursorObject] call mts_map_fnc_pickupMap
 *
 */

params [["_player", objNull, [objNull]], ["_map", objNull, [objNull]]];

CHECK(isNull _player || isNull _map);

[_player, "pickup"] call FUNC(playMapSound);
_player playAction "PutDown";

[{((animationState (_this select 0)) select [25,7]) isEqualTo "putdown"}, {
    params ["_player", "_map"];

    [QGVAR(removeMap), _map] call CBA_fnc_remoteEvent;

    private _vehicle = attachedTo _map;

    private _mapClass = _map getVariable [QGVAR(mapClass), "ItemMap"];

    deleteVehicle _map;

    if (!isNull _vehicle) then {
        _vehicle setVariable [QGVAR(isMapOnVehicle), false, true];
    };

    GVAR(hasMap) = true;
    _player linkItem _mapClass;
}, _this] call CBA_fnc_waitUntilAndExecute;
