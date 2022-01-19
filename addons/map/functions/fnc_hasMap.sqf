#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Returns true if unit has a map; otherwise false.
 *
 *  Parameter(s):
 *      0: OBJECT - Unit to check.
 *
 *  Returns:
 *      BOOLEAN - Unit has a map.
 *
 *  Example:
 *      [player] call mts_map_fnc_hasMap
 *
 */

params ["_player"];

private _map = (assignedItems _player) param [0, ""];
private _hasMap = getText (configFile >> "CfgWeapons" >> _map >> "simulation") == "ItemMap";

_hasMap
