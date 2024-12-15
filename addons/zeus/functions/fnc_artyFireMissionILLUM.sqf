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
 *      2: NUMBER - Time on target in seconds. (optional, default: immediately)
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      [[400,300], [100,100,0], 5] call mts_zeus_fnc_artyFireMissionILLUM
 *
 */

params [
    ["_position", [0,0], [[]]],
    ["_impactArea", [0,0,0], [[]]],
    ["_timeOnTarget", 0, [0]]
];

[
    LLSTRING(artillery_firemission_illum),
    [
        ["EDIT", LLSTRING(artillery_ammoAmount), ["4"]],
        ["EDIT", LLSTRING(artillery_detonationHight), ["200"]],
        ["COMBO", LLSTRING(artillery_delayType), [[0, 1, 2], [LLSTRING(artillery_delay), LLSTRING(artillery_durationWithAmmo), LLSTRING(artillery_durationWithDelay)], 0]],
        ["EDIT", LLSTRING(artillery_delay), ["25"]],
        ["EDIT", LLSTRING(artillery_duration), ["60"]]
    ],
    {
        (_this select 0) params ["_ammoAmount", "_detonationHight", "_delayType", "_delay", "_duration"];
        (_this select 1) params ["_position", "_impactArea", "_timeOnTarget"];

        _ammoAmount = parseNumber _ammoAmount;
        _detonationHight = parseNumber _detonationHight;
        _delay = parseNumber _delay;
        _duration = parseNumber _duration;

        if (_delay < 0 || _detonationHight < 150 || _duration < 0) exitWith {
            [LLSTRING(artillery_errorDelayOrHight)] call zen_common_fnc_showMessage;
        };
        if (_ammoAmount <= 0) exitWith {
            [LLSTRING(artillery_errorAmount)] call zen_common_fnc_showMessage;
        };

        switch (_delayType) do {
            case 0: {
                [_position, QGVAR(artillery_ILLUM), _ammoAmount, false, _delay, _detonationHight, _impactArea, _timeOnTarget] call FUNC(execArtyStrike);
            };
            case 1: {
                [_position, QGVAR(artillery_ILLUM), _ammoAmount, true, _duration, _detonationHight, _impactArea, _timeOnTarget] call FUNC(execArtyStrike);
            };
            case 2: {
                _ammoAmount = ceil (_duration / _delay);
                [_position, QGVAR(artillery_ILLUM), _ammoAmount, false, _delay, _detonationHight, _impactArea, _timeOnTarget] call FUNC(execArtyStrike);
            };
        };
    },
    {},
    [_position, _impactArea, _timeOnTarget]
] call zen_dialog_fnc_create;
