#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Saves status of the Arsenal button into namespace and database or at client disable/enables arsenal on the fly.
 *
 *  Parameter(s):
 *      0: STRING - Equipment  name
 *      1: BOOLEAN - On/off state of Arsenal
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      ["323" , false] call mts_armory_fnc_toggleArsenal
 *
 */

private _argsSuccessfullyParsed = params [["_equipmentName", "", [""]], ["_status", false, [false]]];
TRACE_3("",_equipmentName,_status,_argsSuccessfullyParsed);

CHECK(!GVAR(initialized) || !_params);

if (isDedicated || (isServer && GVAR(allowPlayerDBConnection))) then {
    private _equipmentArray = GVAR(equipment) getVariable [_equipmentName, []];
    private _equipmentID = _equipmentArray param [2, 0];

    _equipmentArray set [5, _status];
    GVAR(equipment) setVariable [_equipmentName, _equipmentArray, true];

    [GVAR(sessionID), "updateArsenal", _status, _equipmentID] call DB_SET;
} else {
    private _armoryDisplay = findDisplay IDD_EQUIPMENT;
    private _arsenalDisplay = findDisplay IDD_ACE_ARSENAL;
    TRACE_2("",_armoryDisplay,_arsenalDisplay);

    if !(isNull _armoryDisplay) exitWith {
        private _title = ctrlText IDC_TEXT_TITLE;

        if (_title isEqualTo _equipmentName) then {
            ctrlShow [IDC_BUTTON_ARSENAL, _status];
        };
    };
    if !(isNull _arsenalDisplay) exitWith {
        _arsenalDisplay closeDisplay 1;
    };
};
