#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Toggles the setting menu on/off.
 *
 *  Parameter(s):
 *      0: BOOLEAN - if the settings should be toggled in an instant
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      call mts_armory_fnc_toggleSettings
 *
 */

params [["_fastSwitch", false, [false]]];

private _display = findDisplay IDD_EQUIPMENT;
CHECK(!GVAR(initialized) || isNull _display);

private _ctrlBackground1 = _display displayCtrl IDC_BACKGROUND_1;
private _ctrlBackground2 = _display displayCtrl IDC_BACKGROUND_2;
private _posBackground1 = ctrlPosition _ctrlBackground1;
private _posBackground2 = ctrlPosition _ctrlBackground2;

if (ctrlVisible IDC_BUTTON_SAVE_EQUIPMENT) then {
    _posBackground1 set [3, BACKGROUND_1_DEFAULT_HEIGHT];
    _posBackground2 set [3, BACKGROUND_2_DEFAULT_HEIGHT];

    private _arsenal = ((GVAR(equipment) getVariable [ctrlText IDC_TEXT_TITLE, []]) param [5, false]);
    if !(_arsenal) then {
        ctrlShow [IDC_BUTTON_ARSENAL, false];
    };

    {ctrlShow [_x, false]} count GVAR(IDCsToHide);
} else {
    _posBackground1 set [3, BACKGROUND_1_EXTENDED_HEIGHT];
    _posBackground2 set [3, BACKGROUND_2_EXTENDED_HEIGHT];

    [{
        {ctrlShow [_x, true]} count GVAR(IDCsToHide);
        ctrlShow [IDC_BUTTON_ARSENAL, true];
    }, [], 0.2] call CBA_fnc_waitAndExecute;
};

_ctrlBackground1 ctrlSetPosition _posBackground1;
_ctrlBackground2 ctrlSetPosition _posBackground2;

if (_fastSwitch) then {
    _ctrlBackground1 ctrlCommit 0;
    _ctrlBackground2 ctrlCommit 0;
} else {
    _ctrlBackground1 ctrlCommit 0.2;
    _ctrlBackground2 ctrlCommit 0.2;
};
