#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Attaches flag to the back of the unit and removes his flag item.
 *
 *  Parameter(s):
 *      0: OBJECT - Unit.
 *      1: STRING - Flag item.
 *
 *  Returns:
 *       Nothing.
 *
 *  Example:
 *      [player, "mts_flags_white"] call mts_flags_fnc_carryFlag
 *
 */

params ["_unit", "_item"];
TRACE_2("Carry flag",_unit,_item);

(GVAR(flagItemCache) get _item) params ["", "_texture"];
_unit forceFlagTexture _texture;

_unit setVariable [QGVAR(carryingFlag), _item, true];
_unit removeItem _item;
