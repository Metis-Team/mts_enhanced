#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Checks if the unit wears a PBW uniform that has cords.
 *
 *  Parameter(s):
 *      0: OBJECT - Unit
 *
 *  Returns:
 *      BOOL - Unit is wearing a PBW uniform that has cords.
 *
 *  Example:
 *      [player] call mts_cords_fnc_hasPBWUniform
 *
 */

params ["_unit"];

private _uniform = uniform _unit;
GVAR(uniforms) findIf {_x == _uniform} isNotEqualTo -1
