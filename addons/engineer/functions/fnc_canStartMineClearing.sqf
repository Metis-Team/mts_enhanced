#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Checks if the vehicle can start clearing mines.
 *
 *  Parameter(s):
 *      0: OBJECT - Mine clearing vehicle (ABV/MiRPz)
 *      1: OBJECT - Caller
 *
 *  Returns:
 *      BOOLEAN - Can start clearing mines.
 *
 *  Example:
 *      _this call mts_engineer_fnc_canStartMineClearing
 *
 */

params ["_vehicle", "_caller"];

(_caller isEqualTo (driver _vehicle)) && // is driver of the vehicle
{_vehicle getVariable [QGVAR(enableMineClearing), true]} && // mine clearing enabled
{!(_vehicle getVariable [QGVAR(mineClearingActive), false])} && // not already mine clearing
{speed _vehicle <= MAX_MINE_CLEARING_SPEED} &&
{isEngineOn _vehicle}
