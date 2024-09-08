#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Returns the parameters needed for mts_map_fnc_placeMapOnVehicle.
 *      How to use: Place vehicle and map how you want the map to be placed when the action is performed.
 *      Call this function and pass the vehicle and map objects. The returned array are the parameters.
 *
 *  Parameter(s):
 *      0: OBJECT - Vehicle the map is placed on.
 *      1: OBJECT - The placeholder map object.
 *
 *  Returns:
 *      ARRAY - Parameters for mts_map_fnc_placeMapOnVehicle.
 *
 *  Example:
 *      [this, map1] call mts_map_fnc_getPlaceMapOnVehicleParams
 *
 */

params [["_vehicle", objNull, [objNull]], ["_mapObj", objNull, [objNull]]];

CHECK(isNull _vehicle || isNull _mapObj);

private _class = typeOf _vehicle;
private _offset = _vehicle worldToModelVisual (ASLToAGL (getPosASLVisual _mapObj));
private _vectorDir = vectorDir _mapObj;
private _vectorUp = vectorUp _mapObj;

[_class, _offset, [_vectorDir, _vectorUp]]
