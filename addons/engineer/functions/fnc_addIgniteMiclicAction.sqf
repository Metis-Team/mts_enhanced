#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds a hold action for igniting given MICLIC. This function has local effect.
 *
 *  Parameter(s):
 *      0: OBJECT - The MICLIC to add the action to.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [this] call mts_engineer_fnc_addIgniteMiclicAction
 *
 */

#define ACTION_DURATION 3 // Seconds
#define ACTION_RANGE 2 // Meters

params ["_miclic"];

CHECK(!hasInterface);

private _iconPath = "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\destroy_ca.paa";
[
    _miclic,
    LLSTRING(igniteMiclic),
    _iconPath,
    _iconPath,
    QUOTE(_this distance _target < ACTION_RANGE),
    QUOTE(_caller distance _target < ACTION_RANGE),
    {},
    {},
    {
        params ["_miclic"];
        [_miclic] remoteExecCall [QFUNC(igniteMiclic), 2];
    },
    {},
    [],
    ACTION_DURATION,
    100,
    true,
    false
] call BIS_fnc_holdActionAdd;
