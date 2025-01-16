#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Sanitize input to be a positive integer greater 0.
 *
 *  Parameter(s):
 *      0: STRING - Edit box value.
 *
 *  Returns:
 *      STRING - Sanitized edit box value.
 *
 *  Example:
 *      ["5"] call mts_zeus_fnc_positiveInteger
 *
 */

params ["_value"];

_value = floor parseNumber _value;

if (_value <= 0) then {
    _value = 1;
};

str _value
