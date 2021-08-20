#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0: [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 *  Example:
 *      [[arguments]] call [function name]
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
