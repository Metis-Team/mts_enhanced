#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Disables suppression for the unit.
 *
 *  Parameter(s):
 *      0: OBJECT - Unit.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [_unit] call mts_zeus_fnc_disableSuppression
 *
 */

params [["_unit", objNull, [objNull]]];

CHECK(isNull _unit);

[_unit] call FUNC(removeSuppressedLocalUnit);

if (_x getVariable [QGVAR(suppressionEnabled), false]) then {
    _unit setVariable [QGVAR(suppressionEnabled), false, true];
};
