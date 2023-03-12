#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Get the placeable and carryable flags in the unit's inventory.
 *
 *  Parameter(s):
 *      0: OBJECT - Unit
 *
 *  Returns:
 *       ARRAY - Flag items.
 *
 *  Example:
 *      [player] call mts_flags_fnc_getFlags
 *
 */

params ["_unit"];

(_unit call ace_common_fnc_uniqueItems) arrayIntersect keys GVAR(flagItemCache)
