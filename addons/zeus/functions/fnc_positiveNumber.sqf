#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Sanitize input to be a positive number including 0.
 *
 *  Parameter(s):
 *      0: STRING - Edit box value.
 *
 *  Returns:
 *      STRING - Sanitized edit box value.
 *
 *  Example:
 *      ["0.6"] call mts_zeus_fnc_positiveInteger
 *
 */

params ["_value"];

private _filter = toArray ".0123456789";
private _newValue = toString (toArray _value select {_x in _filter});

if (_newValue isEqualTo "") exitWith {"0"};

_newValue
