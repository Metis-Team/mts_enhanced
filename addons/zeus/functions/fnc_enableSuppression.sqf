#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Enables suppression on the unit.
 *      Must be called where unit is local.
 *
 *  Parameter(s):
 *      0: OBJECT - Unit.
 *      1: NUMBER - Unit will change stance if suppression is higher than this threshold value.
 *      2: STRING - The stance to take when unit is suppressed (DOWN, MIDDLE, UP).
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [_unit, 0.7, "MIDDLE"] call mts_zeus_fnc_enableSuppression
 *
 */

params [["_unit", objNull, [objNull]], ["_suppressionThreshold", -1, [0]], ["_suppressedStance", "", [""]]];

CHECK(isNull _unit || !local _unit || _unit getVariable [ARR_2(QGVAR(suppressionEnabled), false)]);
CHECK(_suppressionThreshold < 0 || _suppressionThreshold > 1);
_suppressedStance = toUpper _suppressedStance;
CHECK(!(_suppressedStance in [ARR_3("DOWN", "MIDDLE", "UP")]));

private _originalStance = GVAR(stanceMapping) getOrDefault [stance _unit, "UP"];

_unit setVariable [QGVAR(suppressionEnabled), true, true];
_unit setVariable [QGVAR(suppressionParameters), [_suppressionThreshold, _suppressedStance, _originalStance], true];

[_unit] call FUNC(addSuppressedLocalUnit);
