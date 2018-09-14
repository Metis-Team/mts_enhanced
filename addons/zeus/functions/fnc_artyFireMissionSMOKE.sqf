/**
 *  Author: Timi007
 *
 *  Description:
 *      Opens Dialog where more information for a SMOKE strike is transmitted.
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
 *      [[400,300], [100,100,0], 0] call mts_zeus_fnc_artyFireMissionSMOKE
 *
 */
#include "script_component.hpp"

params [
    ["_position", [0,0], [[]]],
    ["_impactArea", [0,0,0], [[]]],
    ["_timeOnTarget", 0, [0]]
];

private _dialog_data = [
    LLSTRING(artillery_firemission_smoke),
    [
        [LLSTRING(artillery_ammoAmount), "", "1"],
        [LLSTRING(artillery_delayType), [LLSTRING(artillery_delay), LLSTRING(artillery_durationWithAmmo), LLSTRING(artillery_durationWithDelay)], 0],
        [LLSTRING(artillery_delay), "", "15"],
        [LLSTRING(artillery_duration), "", "60"]
    ]
] call Ares_fnc_showChooseDialog;

CHECK(_dialog_data isEqualTo []);

_dialog_data params ["_ammoAmount", "_delayType", "_delay", "_duration"];
_ammoAmount = parseNumber _ammoAmount;
_delay = parseNumber _delay;
_duration = parseNumber _duration;

if (_delay < 0 || _duration < 0) exitWith {
    [LLSTRING(artillery_errorDelayOrHight)] call Ares_fnc_ShowZeusMessage;
};
if (_ammoAmount <= 0) exitWith {
    [LLSTRING(artillery_errorAmount)] call Ares_fnc_ShowZeusMessage;
};

if (_delayType isEqualTo 0) then {
    [_position, "Smoke_120mm_AMOS_White", _ammoAmount, false, _delay, 0, _impactArea, _timeOnTarget] call FUNC(execArtyStrike);
};
if (_delayType isEqualTo 1) then {
    [_position, "Smoke_120mm_AMOS_White", _ammoAmount, true, _duration, 0, _impactArea, _timeOnTarget] call FUNC(execArtyStrike);
};
if (_delayType isEqualTo 2) then {
    _ammoAmount = ceil (_duration / _delay);
    [_position, "Smoke_120mm_AMOS_White", _ammoAmount, false, _delay, 0, _impactArea, _timeOnTarget] call FUNC(execArtyStrike);
};
