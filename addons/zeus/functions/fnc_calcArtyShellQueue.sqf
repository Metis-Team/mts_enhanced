#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Calculates the delays, pos and velocity of artillery shells.
 *
 *  Parameter(s):
 *      0: ARRAY - Center position of the impact area (2D or 3D; z makes no difference).
 *      1: STRING - Class of artillery shell.
 *      2: NUMBER - Simulated number of units firing.
 *      3: NUMBER - Number of shots per unit.
 *      4: BOOLEAN - Is duration being used? (or delay). (optional, default: false (delay active))
 *      5: NUMBER - Delay between shell in seconds (25% inaccuracy). If parameter 3 is true than it's the duration of the fire mission (optional, default: 1)
 *      6: NUMBER - Hight above ground for shell detonation/airburst [m] (optional, default: 0)
 *      7: ARRAY - Area where the shells should land. Format: [length [m] <NUMBER>, width [m] <NUMBER>, angle [°] <NUMBER>] (optional, default: parameter 0)
 *      8: NUMBER - Time on target in seconds. (optional, default: immediately)
 *
 *  Returns:
 *      ARRAY - Queue of shells to spawn sorted by delay descending. Format [_delay, _ammoType, _pos, _velocity, _detonationHight].
 *
 *  Example:
 *      [[400,500], "Sh_155mm_AMOS", 5, false, 1, 0, [200,100,25], 5] call mts_zeus_fnc_calcArtyShellQueue
 *
 */

params [
    ["_centerPos", [], [[]]],
    ["_ammoType", "", [""]],
    ["_numberOfUnits", 1, [0]],
    ["_shotsPerUnit", 1, [0]],
    ["_isDurationNotDelay", false, [false]],
    ["_delay", 1, [0]],
    ["_detonationHight", 0, [0]],
    ["_impactArea", [0,0,0], [[]]],
    ["_timeOnTarget", 0, [0]]
];
_impactArea params [
    ["_areaLength", 0, [0]],
    ["_areaWidth", 0, [0]],
    ["_areaAngle", 0, [0]]
];

CHECK(_centerPos isEqualTo [] || _ammoType isEqualTo "");

//Don't allow negative numbers
if (_delay < 0) then {_delay = 0;};
if (_detonationHight < 0) then {_detonationHight = 0;};
if (_timeOnTarget < 0) then {_timeOnTarget = 0;};

//Calculate new delay with the duration and ammo amount
if (_isDurationNotDelay) then {
    _delay = _delay / _ammoAmount;
};

private _diffDelay = _delay * 0.25; //Random 25% chance for inaccuracy

private _projectileQueue = [];

for "_shot" from 0 to (_shotsPerUnit - 1) do {
    for "_unit" from 0 to (_numberOfUnits - 1) do {
        // Set spawn hight and velocity
        private _pos = [[_centerPos, _areaLength, _areaWidth, _areaAngle, true]] call CBA_fnc_randPosArea; // Find random pos in impact area
        private _velocity = [0, 0, 0];
        private _airburstHeight = _detonationHight;

        if (_ammoType isEqualTo QGVAR(artillery_ILLUM)) then {
            _pos set [2, _detonationHight];
            _velocity = [0, 0, -3];
            _airburstHeight = 0;
        } else {
            _pos set [2, random [300, 600, 900]]; // Random spawn height, again for inaccuracy
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

        _projectileQueue pushBack [_randDelay, _ammoType, _pos, _velocity, _airburstHeight];
    };
};

[_projectileQueue, [], {_x select 0}, "DESCEND"] call BIS_fnc_sortBy
