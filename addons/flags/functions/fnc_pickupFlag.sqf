#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Picks up flag and adds item to unit.
 *
 *  Parameter(s):
 *      0: OBJECT - Unit.
 *      1: STRING - Flag item.
 *      2: OBJECT - Flag pole (gets deleted later).
 *
 *  Returns:
 *       Nothing.
 *
 *  Example:
 *      [player, "mts_flags_white", my_flag] call mts_flags_fnc_pickupFlag
 *
 */

params ["_unit", "_item", "_flag"];
TRACE_3("Flag pickup",_unit,_item,_flag);

[_unit, "PutDown"] call ace_common_fnc_doGesture;

[{
    params ["_unit", "_item", "_flag"];

    [_unit, _item] call ace_common_fnc_addToInventory;
    deleteVehicle _flag;
}, [_unit, _item, _flag], 0.7] call CBA_fnc_waitAndExecute;
