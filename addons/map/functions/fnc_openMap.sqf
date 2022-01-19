#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Opens the map for a unit even if the unit has no map.
 *
 *  Parameter(s):
 *      0: OBJECT - Unit which should open a map.
 *      1: OBJECT - The map object which the player interacted with.
 *                  If this object is picked up, all units looking inside this map are forced out.
 *
 *  Returns:
 *      BOOLEAN - Return true if the map of the unit is open.
 *
 *  Example:
 *      [player, cursorObject] call mts_map_fnc_openMap
 *
 */

params [["_player", objNull, [objNull]], ["_map", objNull, [objNull]]];

CHECK(isNull _player || isNull _map);

if ([_player] call FUNC(hasMap)) then {
    GVAR(hasMap) = true;
} else {
    GVAR(hasMap) = false;

    private _mapClass = _map getVariable [QGVAR(mapClass), "ItemMap"];
    _player linkItem _mapClass;
};

GVAR(map) = _map;
openMap true;
