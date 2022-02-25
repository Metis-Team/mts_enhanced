#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Removes a unit from the suppressed units which are on this local machine.
 *
 *  Parameter(s):
 *      0: OBJECT - Unit.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [_unit] call mts_zeus_fnc_removeSuppressedLocalUnit
 *
 */

params ["_unit"];

CHECK(isNil QGVAR(suppressedLocalUnits));

private _index = GVAR(suppressedLocalUnits) findIf {_x isEqualTo _unit};
// Unit wasn't suppressed before
CHECK(_index < 0);
GVAR(suppressedLocalUnits) deleteAt _index;
