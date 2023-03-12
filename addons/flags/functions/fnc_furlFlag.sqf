#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Stops carrying flag and adds flag item back to unit.
 *
 *  Parameter(s):
 *      0: OBJECT - Unit.
 *
 *  Returns:
 *       Nothing.
 *
 *  Example:
 *      [player] call mts_flags_fnc_furlFlag
 *
 */

params ["_unit"];

// Stop carrying flag and add flag item to unit.
_item = _unit getVariable [QGVAR(carryingFlag), ""];
_unit setVariable [QGVAR(carryingFlag), nil, true];

_unit forceFlagTexture ""; // Remove flag

[_unit, _item] call ace_common_fnc_addToInventory;
