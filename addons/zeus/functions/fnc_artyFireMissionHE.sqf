#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Opens Dialog where more information for a HE strike is transmitted.
 *
 *  Parameter(s):
 *      0: ARRAY - Target area where the shells should land.
 *          0: OBJECT - Target logic indicating center pos and angle of area.
 *          1: NUMBER - Width of target area.
 *          2: NUMBER - Depth of target area.
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      [[_logic, 100, 50]] call mts_zeus_fnc_artyFireMissionHE
 *
 */

[
    LLSTRING(artillery_fireMission_he),
    [
        [
            "COMBO",
            LLSTRING(artillery_ammoType),
            [GVAR(artilleryShellsAmmoCache), GVAR(artilleryShellsNameCache), 0]
        ],
        ["EDIT", LLSTRING(artillery_numberOfUnits), ["4", FUNC(positiveInteger)]],
        ["EDIT", LLSTRING(artillery_shotsPerUnit), ["1", FUNC(positiveInteger)]],
        ["COMBO", LLSTRING(artillery_airburst), [[0, 1, 2, 3], [LLSTRING(artillery_airburst_no), LLSTRING(artillery_airburst_low), LLSTRING(artillery_airburst_med), LLSTRING(artillery_airburst_high)], 0]],
        ["COMBO", LLSTRING(artillery_delayType), [[0, 1, 2],
            [
                [LLSTRING(artillery_delayBetweenRounds), LLSTRING(artillery_delayBetweenRounds_tooltip)],
                [LLSTRING(artillery_durationWithAmmo), LLSTRING(artillery_durationWithAmmo_tooltip)],
                [LLSTRING(artillery_durationWithDelay), LLSTRING(artillery_durationWithDelay_tooltip)]
            ], 0]],
        ["EDIT", LLSTRING(artillery_delay), ["1", FUNC(positiveNumber)]],
        ["EDIT", LLSTRING(artillery_duration), [DEFAULT_DURATION, FUNC(positiveNumber)]],
        ["EDIT", LLSTRING(artillery_timeOnTarget), [DEFAULT_TOT, FUNC(positiveNumber)]]
    ],
    {
        TRACE_1("params",_this);
        (_this select 0) params ["_ammoType", "_numberOfUnits", "_shotsPerUnit", "_airburstType", "_delayType", "_delay", "_duration", "_timeOnTarget"];
        (_this select 1) params ["_targetArea"];

        _numberOfUnits = parseNumber _numberOfUnits;
        _shotsPerUnit = parseNumber _shotsPerUnit;
        _delay = parseNumber _delay;
        _duration = parseNumber _duration;
        _timeOnTarget = parseNumber _timeOnTarget;

        //select airburst hight
        private _detonationHight = [0, 15, 20, 30] select _airburstType;

        private _args = switch (_delayType) do {
            case 0: {
                [_targetArea, _ammoType, _detonationHight, _numberOfUnits, _shotsPerUnit, false, _delay, _timeOnTarget]
            };
            case 1: {
                [_targetArea, _ammoType, _detonationHight, _numberOfUnits, _shotsPerUnit, true, _duration, _timeOnTarget]
            };
            case 2: {
                _shotsPerUnit = ceil ((_duration / _delay) / _numberOfUnits);
                [_targetArea, _ammoType, _detonationHight, _numberOfUnits, _shotsPerUnit, false, _delay, _timeOnTarget]
            };
        };

        [QGVAR(initFireMission), _args] call CBA_fnc_serverEvent;
    },
    {
        (_this select 1) params ["_targetArea"];
        _targetArea params ["_logic"];

        deleteVehicle _logic;
    },
    _this
] call zen_dialog_fnc_create;
