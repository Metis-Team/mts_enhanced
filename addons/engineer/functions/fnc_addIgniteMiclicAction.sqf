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

params ["_miclic"];

CHECK(!hasInterface);

[
    _miclic,
    LLSTRING(igniteMiclic),
    "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\destroy_ca.paa",
    "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\destroy_ca.paa",
    "_this distance _target < 2",
    "_caller distance _target < 2",
    {},
    {},
    {
        params ["_miclic"];

        [_miclic] remoteExecCall [QFUNC(igniteMiclic), 2];
    },
    {},
    [],
    3,
    100,
    true,
    false
] call BIS_fnc_holdActionAdd;
