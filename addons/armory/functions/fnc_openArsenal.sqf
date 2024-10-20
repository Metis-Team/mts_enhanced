#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Opens the arsenal and reopens the armory if the player can edit the equipment and the settings are shown.
 *
 *  Parameter(s):
 *      0: CONTROL - Displaycontrol of the Arsenal button
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      [control] call mts_armory_fnc_openArsenal
 *
 */

params ["_ctrlArsenal"];
TRACE_1("",_ctrlArsenal);

CHECK(!GVAR(initialized) || isNull _ctrlArsenal);
if (ctrlVisible IDC_BUTTON_SAVE_EQUIPMENT) then {
    private _eventID = ["ace_arsenal_displayClosed", {
            GVAR(arsenalEditorReopeningVars) params ["_equipmentName", "_object", "_idc", "_category", "_eventID"];
            ["ace_arsenal_displayClosed", _eventID] call CBA_fnc_removeEventHandler;
            [_equipmentName, _object, _idc, _category] call FUNC(openArmory);
            GVAR(arsenalEditorReopeningVars) = nil;
    }] call CBA_fnc_addEventhandler;

    private _display = ctrlParent _ctrlArsenal;

    private _object = (_display displayCtrl IDC_BUTTON_NEW_EQUIPMENT) getVariable [QGVAR(attachedObject), objNull];

    private _ctrlSave = (_display displayCtrl IDC_BUTTON_SAVE_EQUIPMENT);
    private _idc = _ctrlSave getVariable [QGVAR(idc), -1];
    private _category =  _ctrlSave getVariable [QGVAR(category), -1];

    GVAR(arsenalEditorReopeningVars) = [ctrlText IDC_TEXT_TITLE, _object, _idc, _category, _eventID];
    TRACE_1("",GVAR(arsenalEditorReopeningVars));
};
closeDialog 0;
[player, player, true] call ace_arsenal_fnc_openBox;
