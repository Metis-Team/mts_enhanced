#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Opens Dialog where more information for an ILLUM strike is transmitted.
 *
 *  Parameter(s):
 *      0: ARRAY - Center position of the impact area (2D or 3D; z makes no difference)
 *      1: ARRAY - Area where the shells should land. Format: [length [m] <NUMBER>, width [m] <NUMBER>, angle [°] <NUMBER>] (optional, default: parameter 0)
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      [[400,300], [100,100,0], 5] call mts_zeus_fnc_artyFireMissionILLUM
 *
 */

private _sanitizeDetonationHeight = {
    params ["_value"];

    _value = parseNumber _value;

    if (_value < MIN_ILLUM_DETONATION_HEIGHT) then {
        _value = MIN_ILLUM_DETONATION_HEIGHT;
    };

    str _value
};

[
    LLSTRING(artillery_fireMission_illum),
    [
        ["EDIT", LLSTRING(artillery_numberOfUnits), ["4", FUNC(positiveInteger)]],
        ["EDIT", LLSTRING(artillery_shotsPerUnit), ["1", FUNC(positiveInteger)]],
        ["EDIT", LLSTRING(artillery_detonationHight), [DEFAULT_ILLUM_DETONATION_HEIGHT, _sanitizeDetonationHeight]],
        ["COMBO", LLSTRING(artillery_delayType), [[0, 1, 2],
            [
                [LLSTRING(artillery_delayBetweenRounds), LLSTRING(artillery_delayBetweenRounds_tooltip)],
                [LLSTRING(artillery_durationWithAmmo), LLSTRING(artillery_durationWithAmmo_tooltip)],
                [LLSTRING(artillery_durationWithDelay), LLSTRING(artillery_durationWithDelay_tooltip)]
            ], 2]],
        ["EDIT", LLSTRING(artillery_delay), ["25", FUNC(positiveNumber)]],
        ["EDIT", LLSTRING(artillery_duration), [DEFAULT_DURATION, FUNC(positiveNumber)]],
        ["EDIT", LLSTRING(artillery_timeOnTarget), [DEFAULT_TOT, FUNC(positiveNumber)]]
    ],
    {
        TRACE_1("params",_this);
        (_this select 0) params ["_numberOfUnits", "_shotsPerUnit", "_detonationHight", "_delayType", "_delay", "_duration", "_timeOnTarget"];
        (_this select 1) params ["_targetArea"];

        _numberOfUnits = parseNumber _numberOfUnits;
        _shotsPerUnit = parseNumber _shotsPerUnit;
        _detonationHight = parseNumber _detonationHight;
        _delay = parseNumber _delay;
        _duration = parseNumber _duration;
        _timeOnTarget = parseNumber _timeOnTarget;

        private _args = switch (_delayType) do {
            case 0: {
                [_targetArea, QGVAR(artillery_ILLUM), _detonationHight, _numberOfUnits, _shotsPerUnit, false, _delay, _timeOnTarget]
            };
            case 1: {
                [_targetArea, QGVAR(artillery_ILLUM), _detonationHight, _numberOfUnits, _shotsPerUnit, true, _duration, _timeOnTarget]
            };
            case 2: {
                _shotsPerUnit = ceil ((_duration / _delay) / _numberOfUnits);
                [_targetArea, QGVAR(artillery_ILLUM), _detonationHight, _numberOfUnits, _shotsPerUnit, false, _delay, _timeOnTarget]
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
