#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Checks if the vehicle can stop clearing mines.
 *
 *  Parameter(s):
 *      0: OBJECT - Mine clearing vehicle (ABV/MiRPz)
 *      1: OBJECT - Caller
 *
 *  Returns:
 *      BOOLEAN - Can stop clearing mines.
 *
 *  Example:
 *      _this call mts_engineer_fnc_canStopMineClearing
 *
 */

params ["_vehicle", "_caller"];

(_caller isEqualTo (driver _vehicle)) && // is driver of the vehicle
{_vehicle getVariable [QGVAR(mineClearingActive), false]} // mine clearing is active
