/**
 *  Author: Killzone Kid, Timi007
 *
 *  Description:
 *      Checks if unit it is in a building.
 *
 *  Parameter(s):
 *      0: OBJECT - The Player.
 *
 *  Returns:
 *      BOOLEAN - Is unit in building?
 *
 *  Example:
 *      [player] call mts_whistle_fnc_isInBuilding
 *
 */
#include "script_component.hpp"

params [["_unit", player, [objNull]]];

private _intersectionArray = lineIntersectsSurfaces [getPosWorld _unit, getPosWorld _unit vectorAdd [0, 0, 50], _unit, objNull, true, 1, "GEOM", "NONE"];

(_intersectionArray select 0) params ["","","","_house"];
if (_house isKindOf "House") exitWith {true};
false
