#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Opens Dialog where more information for a SMOKE strike is transmitted.
 *
 *  Parameter(s):
 *      0: ARRAY - Center position of the impact area (2D or 3D; z makes no difference)
 *      1: ARRAY - Area where the shells should land. Format: [length [m] <NUMBER>, width [m] <NUMBER>, angle [°] <NUMBER>] (optional, default: parameter 0)
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      [[400,300], [100,100,0], 0] call mts_zeus_fnc_artyFireMissionSMOKE
 *
 */

[
    LLSTRING(artillery_fireMission_smoke),
    [
        ["EDIT", LLSTRING(artillery_numberOfUnits), ["4", FUNC(positiveInteger)]],
        ["EDIT", LLSTRING(artillery_shotsPerUnit), ["1", FUNC(positiveInteger)]],
        ["COMBO", LLSTRING(artillery_delayType), [[0, 1, 2], [LLSTRING(artillery_delay), LLSTRING(artillery_durationWithAmmo), LLSTRING(artillery_durationWithDelay)], 2]],
        ["EDIT", LLSTRING(artillery_delay), ["15", FUNC(positiveNumber)]],
        ["EDIT", LLSTRING(artillery_duration), [DEFAULT_DURATION, FUNC(positiveNumber)]],
        ["EDIT", LLSTRING(artillery_timeOnTarget), [DEFAULT_TOT, FUNC(positiveNumber)]]
    ],
    {
        TRACE_1("params",_this);
        (_this select 0) params ["_numberOfUnits", "_shotsPerUnit", "_delayType", "_delay", "_duration", "_timeOnTarget"];
        (_this select 1) params ["_targetArea"];

        _numberOfUnits = parseNumber _numberOfUnits;
        _shotsPerUnit = parseNumber _shotsPerUnit;
        _delay = parseNumber _delay;
        _duration = parseNumber _duration;
        _timeOnTarget = parseNumber _timeOnTarget;

        if (_delay < 0 || _duration < 0) exitWith {
            [LLSTRING(artillery_errorDelayOrHight)] call zen_common_fnc_showMessage;
        };

        switch (_delayType) do {
            case 0: {
                [_targetArea, "Smoke_120mm_AMOS_White", 0, _numberOfUnits, _shotsPerUnit, false, _delay, _timeOnTarget] call FUNC(execArtyStrike);
            };
            case 1: {
                [_targetArea, "Smoke_120mm_AMOS_White", 0, _numberOfUnits, _shotsPerUnit, true, _duration, _timeOnTarget] call FUNC(execArtyStrike);
            };
            case 2: {
                _shotsPerUnit = ceil ((_duration / _delay) / _numberOfUnits);
                [_targetArea, "Smoke_120mm_AMOS_White", 0, _numberOfUnits, _shotsPerUnit, false, _delay, _timeOnTarget] call FUNC(execArtyStrike);
            };
        };
    },
    {
        (_this select 1) params ["_targetArea"];
        _targetArea params ["_logic"];

        deleteVehicle _logic;
    },
    _this
] call zen_dialog_fnc_create;
