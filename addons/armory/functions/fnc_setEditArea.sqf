#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Retrieves and sets necessary values in the edit area.
 *
 *  Parameter(s):
 *      0: NUMBER - Button IDC
 *      1: NUMBER - Category (eg. 1 for Loadout)
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      [1,1] call mts_armory_fnc_setEditArea
 *
 */

private _argsSuccessfullyParsed = params [["_idc", -1, [0]], ["_category", -1, [0]]];

private _display = findDisplay IDD_EQUIPMENT;
private _ctrlSave = _display displayCtrl IDC_BUTTON_SAVE_EQUIPMENT;
TRACE_4("",_idc,_category,_display,_ctrlSave);
CHECK(!GVAR(initialized) || isNull _display || !_argsSuccessfullyParsed || !(_idc > 0) || !(_category > 0));


private _name = ctrlText _idc;
ctrlSetText [IDC_EDITBOX_EQUIPMENT_NAME, _name];
_ctrlSave setVariable [QGVAR(oldName), _name];
_ctrlSave setVariable [QGVAR(category), _category];
_ctrlSave setVariable [QGVAR(idc), _idc];

if (_category isEqualTo LOADOUT) then {
    if  !(_name isEqualTo "") then {
        (GVAR(equipment) getVariable [ctrlText IDC_TEXT_TITLE, []]) params ["_loadoutNamespace"];

        (_loadoutNamespace getVariable [_name, []]) params ["", "", "", "_ace_medic", "_ace_engineer"];
        lbsetCurSel [IDC_LISTBOX_MEDIC, _ace_medic];
        lbsetCurSel [IDC_LISTBOX_ENGINEER, _ace_engineer];
    } else {
        lbsetCurSel [IDC_LISTBOX_MEDIC, 0];
        lbsetCurSel [IDC_LISTBOX_ENGINEER, 0];
    };
    ctrlShow [IDC_LISTBOX_MEDIC, true];
    ctrlShow [IDC_LISTBOX_ENGINEER, true];
} else {
    ctrlShow [IDC_LISTBOX_MEDIC, false];
    ctrlShow [IDC_LISTBOX_ENGINEER, false];
};
