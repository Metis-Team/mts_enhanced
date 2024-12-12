#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Opens Dialog where more information for a HE strike is transmitted.
 *
 *  Parameter(s):
 *      0: ARRAY - Center position of the impact area (2D or 3D; z makes no difference)
 *      1: STRING - Class of artillery shell
 *      2: ARRAY - Area where the shells should land. Format: [length [m] <NUMBER>, width [m] <NUMBER>, angle [°] <NUMBER>] (optional, default: parameter 0)
 *      3: NUMBER - Time on target in seconds. (optional, default: immediately)
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      [[400,300], "Sh_155mm_AMOS", [100,100,0], 5] call mts_zeus_fnc_artyFireMissionHE
 *
 */

params [
    ["_position", [0,0,0], [[]]],
    ["_ammoType", "", [""]],
    ["_impactArea", [0,0,0], [[]]],
    ["_timeOnTarget", 0, [0]]
];

//open UI
[
    LLSTRING(artillery_firemission_he),
    [
        ["EDIT", LLSTRING(artillery_ammoAmount), ["4"]],
        ["COMBO", LLSTRING(artillery_airburst), [[0, 1, 2 , 3], [LLSTRING(artillery_airburst_no), LLSTRING(artillery_airburst_low), LLSTRING(artillery_airburst_med), LLSTRING(artillery_airburst_high)], 0]],
        ["COMBO", LLSTRING(artillery_delayType), [[0, 1, 2], [LLSTRING(artillery_delay), LLSTRING(artillery_durationWithAmmo), LLSTRING(artillery_durationWithDelay)], 0]],
        ["EDIT", LLSTRING(artillery_delay), ["1"]],
        ["EDIT", LLSTRING(artillery_duration), ["60"]]
    ],
    {
        (_this select 0) params ["_ammoAmount", "_airburstType", "_delayType", "_delay", "_duration"];
        (_this select 1) params ["_position", "_ammoType", "_impactArea", "_timeOnTarget"];

        _ammoAmount = parseNumber _ammoAmount;
        _delay = parseNumber _delay;
        _duration = parseNumber _duration;

        if (_delay < 0 || _duration < 0) exitWith {
            [LLSTRING(artillery_errorDelayOrHight)] call zen_common_fnc_showMessage;
        };
        if (_ammoAmount <= 0) exitWith {
            [LLSTRING(artillery_errorAmount)] call zen_common_fnc_showMessage;
        };

        //select airburst hight
        private _detonationHight = [0, 15, 20, 30] select _airburstType;

        switch (_delayType) do {
            case 0: {
                [_position, _ammoType, _ammoAmount, false, _delay, _detonationHight, _impactArea, _timeOnTarget] call FUNC(execArtyStrike);
            };
            case 1: {
                [_position, _ammoType, _ammoAmount, true, _duration, _detonationHight, _impactArea, _timeOnTarget] call FUNC(execArtyStrike);
            };
            case 2: {
                _ammoAmount = ceil (_duration / _delay);
                [_position, _ammoType, _ammoAmount, false, _delay, _detonationHight, _impactArea, _timeOnTarget] call FUNC(execArtyStrike);
            };
        };
    },
    {},
    [_position, _ammoType, _impactArea, _timeOnTarget]
] call zen_dialog_fnc_create;
