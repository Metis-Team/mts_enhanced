#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Saves the given loadout/backpack.
 *
 *  Parameter(s):
 *      0: CONTROL - Buttoncontrol
 *      1: BOOLEAN - Delete Loadout/Backpack (default: false)
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      [buttonControl] call mts_armory_fnc_saveEquipment
 *
 */

params [["_ctrlSave", controlNull, [controlNull]],["_delete", false, [false]]];

TRACE_2("",_ctrlSave,_delete);
CHECK(!GVAR(initialized) || isNull _ctrlSave);

private _oldName = _ctrlSave getVariable [QGVAR(oldName), ""];
private _category = _ctrlSave getVariable [QGVAR(category), 0];
private _idc = _ctrlSave getVariable [QGVAR(idc), -1];

TRACE_3("",_oldName,_category,_idc);

CHECK(_category isEqualTo 0 || _idc isEqualTo -1);

// Set ACRE base classes
private _replaceRadioAcre = {
    params ["_item"];
    // Replace only if string (array can be eg. weapon inside container) and an ACRE radio
    if (!(_item isEqualType []) && {[_item] call acre_api_fnc_isRadio}) then {
        _this set [0, [_item] call acre_api_fnc_getBaseRadio];
    };
};

(GVAR(equipment) getVariable [ctrlText IDC_TEXT_TITLE, []]) params ["_loadoutNamespace", "_backpackNamespace"];
private _name = ctrlText IDC_EDITBOX_EQUIPMENT_NAME;
CHECKRET(_name isEqualTo "",hint LLSTRING(error_nameNotEmpty));
_ctrlSave setVariable [QGVAR(oldName), _name];

switch (_category) do {
    case (LOADOUT): {
        if (_delete) then {
            _loadoutNamespace setVariable [_oldName, [], true];
            _name = "";
        } else {
            private _ace_medic = lbCurSel IDC_LISTBOX_MEDIC;
            private _ace_engineer = lbCurSel IDC_LISTBOX_ENGINEER;
            private _loadout = getUnitLoadout player;

            if (isClass (configFile >> "CfgPatches" >> "acre_api")) then {
                if ((_loadout select 3) isNotEqualTo []) then {
                    {_x call _replaceRadioAcre} forEach ((_loadout select 3) select 1); // Uniform items
                };
                if ((_loadout select 4) isNotEqualTo []) then {
                    {_x call _replaceRadioAcre} forEach ((_loadout select 4) select 1); // Vest items
                };
                if ((_loadout select 5) isNotEqualTo []) then {
                    {_x call _replaceRadioAcre} forEach ((_loadout select 5) select 1); // Backpack items
                };
            };
            if (_name isNotEqualTo _oldName) then {
                _loadoutNamespace setVariable [_oldName, [], true];
            };

            _loadoutNamespace setVariable [_name, [_name, _idc, _loadout, _ace_medic, _ace_engineer], true];
        };
        [QGVAR(updateLoadout), [ctrlText IDC_TEXT_TITLE, _name, _oldName]] call CBA_fnc_serverEvent;
    };
    case (BACKPACK): {
        if (_delete) then {
            _backpackNamespace setVariable [_oldName, [], true];
            _name = "";
        } else {
            private _class = backpack player;
            private _items = backpackItems player;

            if (isClass (configFile >> "CfgPatches" >> "acre_api")) then {
                {
                    if ([_x] call acre_api_fnc_isRadio) then {
                        _items set [_forEachIndex, [_x] call acre_api_fnc_getBaseRadio];
                    };
                } forEach _items;
            };
            if (_name isNotEqualTo _oldName) then {
                _backpackNamespace setVariable [_oldName, [], true];
            };

            _backpackNamespace setVariable [_name, [_name, _idc, _class, _items], true];
        };

        [QGVAR(updateBackpack), [ctrlText IDC_TEXT_TITLE, _name, _oldName]] call CBA_fnc_serverEvent;
    };
};

if (_delete) then {
    ctrlSetText [IDC_EDITBOX_EQUIPMENT_NAME , ""];
    ctrlSetText [_idc, ""];

    _ctrlSave setVariable [QGVAR(oldName), ""];
} else {
    if (_name isNotEqualTo _oldName) then {
        ctrlSetText [_idc, _name];
    };
};
