#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Spawns artillery shells in a given area.
 *
 *  Parameter(s):
 *      0: ARRAY - Center position of the impact area (2D or 3D; z makes no difference)
 *      1: STRING - Class of artillery shell
 *      2: NUMBER - Total amount of artillery shell which will be fired
 *      3: BOOLEAN - Is duration beeing used? (or delay). (optional, default: false (delay active))
 *      4: NUMBER - Delay between shell in seconds (25% inaccuracy). If parameter 3 is true than it's the duration of the fire mission (optional, default: 1)
 *      5: NUMBER - Hight obove ground for shell detonation/airburst [m] (optional, default: 0)
 *      6: ARRAY - Area where the shells should land. Format: [length [m] <NUMBER>, width [m] <NUMBER>, angle [°] <NUMBER>] (optional, default: parameter 0)
 *      7: NUMBER - Time on target in seconds. (optional, default: immediately)
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      [[400,500], "Sh_155mm_AMOS", 5, false, 1, 0, [200,100,25], 5] call mts_zeus_fnc_execArtyStrike
 *
 */

params [
    ["_centerPos", [], [[]]],
    ["_ammoType", "", [""]],
    ["_ammoAmount", 0, [0]],
    ["_isDurationNotDelay", false, [false]],
    ["_delay", 1, [0]],
    ["_detonationHight", 0, [0]],
    ["_impactArea", [0,0,0], [[]]],
    ["_timeOnTarget", 0, [0]]
];
_impactArea params [
    ["_areaLenght", 0, [0]],
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

private _randDelay = 0;
private _diffDelay = (_delay * 0.25); //Random 25% chance for inaccuracy
private _calcDelay = _delay;

private _firstRun = true;

for "_i" from 0 to (_ammoAmount - 1) do {
    private _randPosInArea = [[_centerPos, _areaLenght, _areaWidth, _areaAngle, true]] call CBA_fnc_randPosArea; //Find random pos in impact area

    //Set spawn hight
    if (_ammoType isEqualTo QGVAR(artillery_ILLUM)) then {
        _randPosInArea set [2, _detonationHight];
    } else {
        private _randSpawnHight = random [300,600,900]; //Again for inaccuracy
        _randPosInArea set [2, _randSpawnHight];
    };

    if (!_firstRun) then {
        //Calculate new delay values for each run
        _randDelay = random [(_calcDelay - _diffDelay), _calcDelay, (_calcDelay + _diffDelay)];
        _calcDelay = _calcDelay + _delay;
    } else {
        //First shot is being fired in _timeOnTarget seconds
        _firstRun = false;
        _randDelay = _timeOnTarget;
        _calcDelay = _timeOnTarget + _delay;
    };

    [{
        //Spawn projectile
        params ["_ammoType", "_randPosInArea", "_detonationHight"];
        private _projectile = createVehicle [_ammotype, _randPosInArea, [], 0, "NONE"];
        if (_ammoType isEqualTo QGVAR(artillery_ILLUM)) then {
            _projectile setvelocity [0,0,-3];
        } else {
            _projectile setvelocity [0,0,-150];

            if !(_detonationHight isEqualTo 0) then {
                [_projectile, _detonationHight] call FUNC(artyAirburst);
            };
        };
    }, [_ammoType, _randPosInArea, _detonationHight], _randDelay] call CBA_fnc_waitAndExecute;
};
