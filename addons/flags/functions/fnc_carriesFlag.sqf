#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Checks if the unit is carrying a flag.
 *
 *  Parameter(s):
 *      0: OBJECT - Unit.
 *
 *  Returns:
 *       BOOLEAN - True if unit is carrying a flag; otherwise flase.
 *
 *  Example:
 *      [player] call mts_flags_fnc_carriesFlag
 *
 */

params ["_unit"];

(_unit getVariable [QGVAR(carryingFlag), ""] isNotEqualTo "") &&
{(getForcedFlagTexture _unit) isNotEqualTo ""}
