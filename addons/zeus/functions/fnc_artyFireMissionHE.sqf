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
#include "script_component.hpp"

params [
    ["_position", [0,0,0], [[]]],
    ["_ammoType", "", [""]],
    ["_impactArea", [0,0,0], [[]]],
    ["_timeOnTarget", 0, [0]]
];
private ["_detonationHight"];

//open UI
private _dialog_data = [
    LLSTRING(artillery_firemission_he),
    [
        [LLSTRING(artillery_ammoAmount), "", "4"],
        [LLSTRING(artillery_airburst), [LLSTRING(artillery_airburst_no), LLSTRING(artillery_airburst_low), LLSTRING(artillery_airburst_med), LLSTRING(artillery_airburst_high)], 0],
        [LLSTRING(artillery_delayType), [LLSTRING(artillery_delay), LLSTRING(artillery_durationWithAmmo), LLSTRING(artillery_durationWithDelay)], 0],
        [LLSTRING(artillery_delay), "", "1"],
        [LLSTRING(artillery_duration), "", "60"]
    ]
] call Ares_fnc_showChooseDialog;

CHECK(_dialog_data isEqualTo []);
_dialog_data params ["_ammoAmount", "_airburstType", "_delayType", "_delay", "_duration"];

_ammoAmount = parseNumber _ammoAmount;
_delay = parseNumber _delay;
_duration = parseNumber _duration;

if (_delay < 0 || _duration < 0) exitWith {
    [LLSTRING(artillery_errorDelayOrHight)] call Ares_fnc_ShowZeusMessage;
};
if (_ammoAmount <= 0) exitWith {
    [LLSTRING(artillery_errorAmount)] call Ares_fnc_ShowZeusMessage;
};

//select airburst hight
_detonationHight = [0, 15, 20, 30] select _airburstType;

if (_delayType isEqualTo 0) then {
    [_position, _ammoType, _ammoAmount, false, _delay, _detonationHight, _impactArea, _timeOnTarget] call FUNC(execArtyStrike);
};
if (_delayType isEqualTo 1) then {
    [_position, _ammoType, _ammoAmount, true, _duration, _detonationHight, _impactArea, _timeOnTarget] call FUNC(execArtyStrike);
};
if (_delayType isEqualTo 2) then {
    _ammoAmount = ceil (_duration / _delay);
    [_position, _ammoType, _ammoAmount, false, _delay, _detonationHight, _impactArea, _timeOnTarget] call FUNC(execArtyStrike);
};
