#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Removes the units map item from the inventory or fails siletly if unit has no map.
 *
 *  Parameter(s):
 *      0: OBJECT - Unit to remove map item from.
 *
 *  Returns:
 *      STRING - Classname of the removed map item.
 *
 *  Example:
 *      [player] call mts_map_fnc_removeMap
 *
 */

params ["_player"];

private _map = (assignedItems _player) param [0, ""];
private _isMap = getText (configFile >> "CfgWeapons" >> _map >> "simulation") == "ItemMap";

CHECKRET(!_isMap,"");

_player unlinkItem _map;

_map
