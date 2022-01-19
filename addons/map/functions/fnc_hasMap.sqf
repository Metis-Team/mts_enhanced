#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0: [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 *  Example:
 *      [[arguments]] call [function name]
 *
 */

params ["_player"];

private _map = (assignedItems _player) param [0, ""];
private _hasMap = getText (configFile >> "CfgWeapons" >> _map >> "simulation") == "ItemMap";

_hasMap
