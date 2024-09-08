#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Checks if the given unit can cut the bush in front of him.
 *
 *  Parameter(s):
 *      0: OBJECT - Unit.
 *      1: NUMBER - Max distance the unit can be away from the bush.
 *
 *  Returns:
 *      BOOLEAN - Can cut the bush.
 *
 *  Example:
 *      [player, 6] call mts_cutter_fnc_canCutBush;
 *
 */

params ["_player", ["_maxDistance", 5, [0]]];

if (!GVAR(bushcutter_enabled)) exitWith {false};
if (!([_player, objNull] call ace_common_fnc_canInteractWith)) exitWith {false};

private _hasItem = if (GVAR(bushcutter_requireItem)) then {
    count (([_player] call ace_common_fnc_uniqueItems) arrayIntersect keys GVAR(bushCutterCache)) > 0
} else {
    true
};

_hasItem && {!isNull ([_player, _maxDistance] call FUNC(seesBush))}
