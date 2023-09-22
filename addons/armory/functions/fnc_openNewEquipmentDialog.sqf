#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Gets attached object and opens "newEquipment" dialog
 *
 *  Parameter(s):
 *      0: CONTROL - Button control of "Button_New_Equipment" from main dialog
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      [_buttonCtrl] call mts_armory_fnc_openNewEquipmentDialog
 *
 */

params [["_buttonCtrl", controlNull, [controlNull]]];

private _attachToObject = _buttonCtrl getVariable [QGVAR(attachedObject), objNull];
closeDialog 0;
createDialog QGVAR(newEquipment);
((findDisplay IDD_NEW_EQUIPMENT) displayCtrl IDC_BUTTON_CREATE) setVariable [QGVAR(attachedObject), _attachToObject];
