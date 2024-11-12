#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Stops the mine clearing process. Must be called where vehicle is local.
 *
 *  Parameter(s):
 *      0: OBJECT - Mine clearing vehicle (ABV/MiRPz)
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [_veh] call mts_engineer_fnc_stopMineClearing
 *
 */

params [["_vehicle", objNull, [objNull]]];

CHECK(isNull _vehicle);
CHECKRET(!local _vehicle,ERROR_1("Called on non-local vehicle '%1'",_vehicle));

if (_vehicle isKindOf "B_APC_Tracked_01_CRV_F") then {
    _vehicle animateSource ["moveplow", 0]; // for vanilla
};
if (_vehicle isKindOf "gm_BPz2a0_base") then {
    _vehicle animateSource ["dozer_blade_elev_source", 0]; // for gm
};

_vehicle setCruiseControl [0, false];

if (_vehicle getVariable [QGVAR(originalIsDamageAllowed), true]) then {
    _vehicle allowDamage true;
};


_vehicle setVariable [QGVAR(mineClearingActive), false, true];
