#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds actions for mine clearing to the vehicle.
 *
 *  Parameter(s):
 *      0: OBJECT - Mine clearing vehicle (ABV/MiRPz)
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      _this call mts_engineer_fnc_initMineClearingActions
 *
 */

params [["_vehicle", objNull, [objNull]]];

_vehicle addAction [
    LLSTRING(startMineClearing),
    {
        params ["_vehicle"];

        [_vehicle] call FUNC(startMineClearing);
    },
    [], // _arguments
    2, // priority
    true, // showWindow
    true, // hideOnUse
    "", // shortcut
    QUOTE([ARR_2(_target,_this)] call FUNC(canStartMineClearing))
];

_vehicle addAction [
    LLSTRING(stopMineClearing),
    {
        params ["_vehicle"];

        [_vehicle] call FUNC(stopMineClearing);
    },
    [], // _arguments
    2, // priority
    true, // showWindow
    true, // hideOnUse
    "", // shortcut
    QUOTE([ARR_2(_target,_this)] call FUNC(canStopMineClearing))
];
