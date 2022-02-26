#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds a unit to the suppressed units which are on this local machine.
 *      Starts the suppression PFH if it doesn't already run on the local machine.
 *
 *  Parameter(s):
 *      0: OBJECT - Unit.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [_unit] call mts_zeus_fnc_addSuppressedLocalUnit
 *
 */

params ["_unit"];

if (isNil QGVAR(suppressedLocalUnits)) then {
    GVAR(suppressedLocalUnits) = [];
    GVAR(suppressedLocalUnits) pushBackUnique _unit;

    [] call FUNC(addAISuppressionPFH);
} else {
    GVAR(suppressedLocalUnits) pushBackUnique _unit;
};
