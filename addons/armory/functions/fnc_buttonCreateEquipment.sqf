#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Gets all information and create new equipment from "newEquipment" dialog
 *
 *  Parameter(s):
 *      0: CONTROL - Button control of "Button_Create_Equipment" from "newEquipment" dialog
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      [_buttonCtrl] call mts_armory_fnc_buttonCreateEquipment
 *
 */

params [["_buttonCtrl", controlNull, [controlNull]]];

private _attachToObject = _buttonCtrl getVariable [QGVAR(attachedObject), objNull];
private _addActionChecked = (ctrlParent _buttonCtrl) displayCtrl IDC_CHECKBOX_EQUIPMENT;
private _equipmentName = ctrlText IDC_EDITBOX_EQUIPMENT;
private _playerUID = getPlayerUID player;

if (_addActionChecked && !isNull _attachToObject) then {
    [QGVAR(createEquipment), [_equipmentName, [_playerUID], _attachToObject]] call CBA_fnc_serverEvent;
} else {
    [QGVAR(createEquipment), [_equipmentName, [_playerUID]]] call CBA_fnc_serverEvent;
};
closeDialog 0;
