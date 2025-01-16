#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Calculates the delays, offsets and velocity of artillery shells.
 *
 *  Parameter(s):
 *      0: ARRAY - Area where the shells should land. Format: [length [m] <NUMBER>, width [m] <NUMBER>]
 *      1: STRING - Class of artillery shell.
 *      2: NUMBER - Hight above ground for shell detonation/airburst [m] (optional, default: 0)
 *      3: NUMBER - Simulated number of units firing.
 *      4: NUMBER - Number of shots per unit.
 *      5: BOOLEAN - Is duration being used? (or delay). (optional, default: false (delay active))
 *      6: NUMBER - Delay between shell in seconds (25% inaccuracy). If parameter 3 is true than it's the duration of the fire mission (optional, default: 1)
 *      7: NUMBER - Time on target in seconds. (optional, default: immediately)
 *
 *  Returns:
 *      ARRAY - Queue of shells to spawn sorted by delay descending. Format [_delay, _ammoType, _offsetFromCenter, _velocity, _detonationHight].
 *
 *  Example:
 *      [[200,100], "Sh_155mm_AMOS", 0, 3, 2, false, 5, 60] call mts_zeus_fnc_calcArtyShellQueue
 *
 */

params [
    ["_targetArea", [0,0,0], [[]]],
    ["_ammoType", "", [""]],
    ["_detonationHight", 0, [0]],
    ["_numberOfUnits", 1, [0]],
    ["_shotsPerUnit", 1, [0]],
    ["_isDurationNotDelay", false, [false]],
    ["_delay", 1, [0]],
    ["_timeOnTarget", 0, [0]]
];
_targetArea params [
    ["_areaLength", 0, [0]],
    ["_areaWidth", 0, [0]]
];

CHECK(_ammoType isEqualTo "");

//Don't allow negative numbers
if (_delay < 0) then {_delay = 0;};
if (_detonationHight < 0) then {_detonationHight = 0;};
if (_timeOnTarget < 0) then {_timeOnTarget = 0;};

//Calculate new delay with the duration and ammo amount
if (_isDurationNotDelay) then {
    _delay = _delay / (_numberOfUnits * _shotsPerUnit);
};

private _diffDelay = _delay * 0.25; //Random 25% chance for inaccuracy

private _projectileQueue = [];

for "_shot" from 0 to (_shotsPerUnit - 1) do {
    for "_unit" from 0 to (_numberOfUnits - 1) do {
        // Set spawn hight and velocity
        private _offset = [[[0, 0, 0], _areaLength / 2, _areaWidth / 2, 0, true]] call CBA_fnc_randPosArea; // Find random offset in impact area
        private _velocity = [0, 0, 0];
        private _airburstHeight = _detonationHight;

        if (_ammoType isEqualTo QGVAR(artillery_ILLUM)) then {
            _offset set [2, _detonationHight];
            _velocity = [0, 0, -3];
            _airburstHeight = 0;
        } else {
            _offset set [2, random [300, 600, 900]]; // Random spawn height, again for inaccuracy
            _velocity = [0, 0, -150];
        };

        private _totalDelay = _timeOnTarget + _delay * _shot;
        private _randDelay = if (_shot isEqualTo 0) then {
            // First shot is being fired in _timeOnTarget seconds, not before
            random [_totalDelay, _totalDelay, (_totalDelay + _diffDelay)]
        } else {
            // Calculate new delay values for each run
            random [(_totalDelay - _diffDelay), _totalDelay, (_totalDelay + _diffDelay)]
        };

        _projectileQueue pushBack [_randDelay, _ammoType, _offset, _velocity, _airburstHeight];
    };
};

[_projectileQueue, [], {_x select 0}, "DESCEND"] call BIS_fnc_sortBy
