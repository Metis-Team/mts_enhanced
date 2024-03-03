#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Creates and fills the armory dialog.
 *
 *  Parameter(s):
 *      0: STRING - Equipment name
 *      1: OBJECT - Object attached to action (optional: usefull for Equipment category creation, to automatically adding an action to given object)
 *      2: NUMBER - IDC of button, for opening settings directly with prefilled values (optional: works only with argument 3)
 *      3: NUMBER - Category of equipment eg. 1 for loadout, 2 for Backpack (optional: works only with argument 2)
 *
 *  Returns:
 *      None
 *
 *  Example:
 *      ["323"] call mts_armory_fnc_openArmory
 *
 */

if (canSuspend) exitWith {
    [{_this call FUNC(openArmory)}, _this] call CBA_fnc_directCall;
};

params [["_equipmentName", "", [""]], ["_object", objNull, [objNull]], ["_idc", -1, [0]], ["_category", -1, [0]]];
TRACE_4("",_equipmentName,_object,_idc,_category);

CHECK(!GVAR(initialized) || _equipmentName isEqualTo "");

private _equipmentNamespaces = GVAR(equipment) getVariable [_equipmentName, []];

if (_equipmentNamespaces isEqualTo []) exitWith {
    LOG("Equipment not in Namespace");
    [QGVAR(initEquipment), [player, QGVAR(openArmory), [_equipmentName, _object, _idc, _category]]] call CBA_fnc_serverEvent;
};
_equipmentNamespaces params ["_loadoutNamespace", "_backpackNamespace", "_equipmentName", "", "_editors", "_arsenal"];

createDialog QGVAR(dialog);
private _display = findDisplay 520600;
CHECK(isNull _display);

ctrlSetText [IDC_TEXT_TITLE, _equipmentName];
if !(isNull _object) then {
    (_display displayCtrl IDC_BUTTON_NEW_EQUIPMENT) setVariable [QGVAR(attachedObject), _object];
};

if (_arsenal) then {
    (_display displayCtrl IDC_CHECKBOX_ARSENAL) cbSetChecked true;
} else {
    ctrlShow [IDC_BUTTON_ARSENAL, false];
};

{
    lbAdd [IDC_LISTBOX_MEDIC, _x];
} forEach [LLSTRING(text_none), LLSTRING(text_medic), LLSTRING(text_doctor)];

{
    lbAdd [IDC_LISTBOX_ENGINEER, _x];
} forEach [LLSTRING(text_none), LLSTRING(text_engineer), LLSTRING(text_AdvEngineer)];

{
    ctrlShow [_x, false];
} count GVAR(IDCsToHide);

if ((getPlayerUID player) in _editors) then {
    ctrlSetText [IDC_EDITBOX_EDITORS, str _editors];
    if (!(_idc isEqualTo -1) && !(_category isEqualTo -1)) then {
        [true] call FUNC(toggleSettings);
        [{
            params ["_idc", "_category"];
            [_idc, _category] call FUNC(setEditArea);
        }, [_idc, _category], 0.25] call CBA_fnc_waitAndExecute;
    };
} else {
    ctrlShow [IDC_BUTTON_NEW_EQUIPMENT, false];
    ctrlShow [IDC_BACKGROUND_NEW_EQUIPMENT, false];
    ctrlShow [IDC_ICON_NEW_EQUIPMENT, false];
    ctrlShow [IDC_BUTTON_SETTINGS, false];
    ctrlShow [IDC_BACKGROUND_SETTINGS, false];
    ctrlShow [IDC_ICON_SETTINGS, false];
};

{
    private _idc = ((_loadoutNamespace getVariable _x) param [1, nil]);
    if !(isNil "_idc") then {
        ctrlSetText [_idc, ((_loadoutNamespace getVariable [_x, []]) param [0, ""])];
    };
} count (allVariables _loadoutNamespace);

{
    private _idc = ((_backpackNamespace getVariable _x) param [1, nil]);
    if !(isNil "_idc") then {
        ctrlSetText [_idc, ((_backpackNamespace getVariable [_x, []]) param [0, ""])];
    };
} count (allVariables _backpackNamespace);
