#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Initiates the artillery fire mission.
 *      Adds the target logic to the edit tree and gives it an ID.
 *      Inits the visualization of the target area.
 *      Executes the fire mission.
 *
 *  Parameter(s):
 *      0: ARRAY - Target area which includes logic / helper object to determine center pos and angle; length and width.
 *      1: STRING - Class of artillery shell.
 *      2: NUMBER - Hight above ground for shell detonation/airburst [m] (optional, default: 0)
 *      3: NUMBER - Simulated number of units firing.
 *      4: NUMBER - Number of shots per unit.
 *      5: BOOLEAN - Is duration being used? (or delay). (optional, default: false (delay active))
 *      6: NUMBER - Delay between shell in seconds (25% inaccuracy). If parameter 3 is true than it's the duration of the fire mission (optional, default: 1)
 *      7: NUMBER - Time on target in seconds. (optional, default: immediately)
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      [[_logic, 200, 100], "Sh_155mm_AMOS", 0, 3, 2, false, 5, 60] call mts_zeus_fnc_initFireMission
 *
 */

if (!isServer) exitWith {
    [QGVAR(initFireMission), _this] call CBA_fnc_serverEvent;
};

params [["_targetArea", [], [[]]]];
_targetArea params [["_targetLogic", objNull, [objNull]]];
if (isNull _targetLogic) exitWith {};

_targetLogic setVariable [QGVAR(targetID), GVAR(nextTargetID), true];

// Add target logic to edit tree
private _name = format [LLSTRING(artillery_fireMission), GVAR(nextTargetID)];
[zen_position_logics_fnc_add, [_targetLogic, _name]] call CBA_fnc_execNextFrame;

GVAR(nextTargetID) = GVAR(nextTargetID) + 1;

// Visualize the target area
private _jipID = [QGVAR(visualizeArtyTargetArea), _targetArea] call CBA_fnc_globalEventJIP;
[_jipID, _targetLogic] call CBA_fnc_removeGlobalEventJIP;

// Handle canceling fire mission
_targetLogic addEventHandler ["Deleted", {
    params ["_targetLogic"];

    private _targetID = _targetLogic getVariable [QGVAR(targetID), -1];
    private _complete = _targetLogic getVariable [QGVAR(fireMissionComplete), false];

    [QGVAR(fireMissionComplete), [_targetID, !_complete]] call CBA_fnc_globalEvent;
}];

// Begin fire mission
_this call FUNC(execFireMission);
