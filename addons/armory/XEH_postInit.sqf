#include "script_component.hpp"

GVAR(initialized) =  false;
[QGVAR(updateArsenal), FUNC(updateArsenal)] call CBA_fnc_addEventHandler;

TRACE_2("", isDedicated, GVAR(cba_settings_playerDBConnection));

if (isDedicated || GVAR(cba_settings_playerDBConnection)) then {

    private _dbConnected = ["armory", "armory.ini"] call DB_CONNECT;
    if (isNil "_dbConnected" || !(_dbConnected select 0)) exitWith {
        WARNING("Can't connect to Database! Disabling module.");
    };
    GVAR(sessionID) = _dbConnected select 1;

    GVAR(equipment) = [true] call CBA_fnc_createNamespace;
    publicVariable QGVAR(equipment);

    GVAR(equipmentInitialized) = [];
    [QGVAR(updateLoadout), FUNC(updateLoadout)] call CBA_fnc_addEventHandler;
    [QGVAR(updateBackpack), FUNC(updateBackpack)] call CBA_fnc_addEventHandler;
    [QGVAR(updateEditors), FUNC(updateEditors)] call CBA_fnc_addEventHandler;
    [QGVAR(createEquipment), FUNC(createEquipment)] call CBA_fnc_addEventHandler;

    [QGVAR(initEquipment), {
        params [["_unit", objNull, [objNull]], ["_callBackEvent", "", [""]], ["_args", [], [[]]]];
        CHECK(!GVAR(initialized) || isNull _unit || _callBackEvent isEqualTo "" || (_args param [ARR_2(0,"")]) isEqualTo "");
        _args params ["_equipmentName"];

        if ([_equipmentName] call FUNC(initEquipment)) then {
            [_callBackEvent, _args, _unit] call CBA_fnc_targetEvent;
        } else {
            [QGVAR(error), [_unit, _callBackEvent, _args], _unit] call CBA_fnc_targetEvent;
        };
    }] call CBA_fnc_addEventhandler;

    GVAR(initialized) =  true;
    publicVariable QGVAR(initialized);
};

if (hasinterface) then {
    [QGVAR(openArmory), FUNC(openArmory)] call CBA_fnc_addEventhandler;
    [QGVAR(equipBackpack), FUNC(equipBackpack)] call CBA_fnc_addEventhandler;
    [QGVAR(equipLoadout), FUNC(equipLoadout)] call CBA_fnc_addEventhandler;

    [QGVAR(error), {
        params ["_unit", "_callBackEvent", "_args"];
        ERROR(format [ARR_4("Something went wrong: Unit: %1 | CallBackEvent: %2 | Args: %3", _unit, _callBackEvent, _args)]);
        if (hasinterface) then {
            hint "MTS Armory:\nSomething went wrong, please take a look into your logfiles.";
        };
    }] call CBA_fnc_addEventhandler;

    [QGVAR(addAction), {
        params [["_equipmentName", "", [""]], ["_object", objNull, [objNull]]];
        CHECK(isNull _object || _equipmentName isEqualTo "");

        if (GVAR(cba_settings_actions) isEqualTo "ace_interaction" && isClass (configFile >> "CfgPatches" >> "ace_interact_menu")) then {
            private _actionOpenArmory = [
                QGVAR(ace_interact_openArmory),
                _equipmentName,
                "",
                {
                    params ["_object", "", "_params"];
                    _params params ["_equipmentName"];

                    [_equipmentName, _object] call FUNC(openArmory);
                },
                {true},
                {},
                [_equipmentName]
            ] call ace_interact_menu_fnc_createAction;
            [_object, 0, ["ACE_MainActions"], _actionOpenArmory] call ace_interact_menu_fnc_addActionToObject;
        } else {
            _object addAction [_equipmentName, {[(_this select 3), (_this select 0)] call FUNC(openArmory)}, _equipmentName];
        };
    }] call CBA_fnc_addEventhandler;

    GVAR(IDCsToHide) = [
        IDC_CHECKBOX_ARSENAL,
        IDC_EDITBOX_EQUIPMENT_NAME,
        IDC_LISTBOX_MEDIC,
        IDC_LISTBOX_ENGINEER,
        IDC_BUTTON_SAVE_EQUIPMENT,
        IDC_BUTTON_DELETE_EQUIPMENT,
        IDC_BACKGROUND_DELETE_EQUIPMENT,
        IDC_ICON_DELETE_EQUIPMENT,
        IDC_EDITBOX_EDITORS,
        IDC_BUTTON_SAVE_EDITORS,
        IDC_BUTTON_EDIT_LOADOUT_1,
        IDC_BUTTON_EDIT_LOADOUT_2,
        IDC_BUTTON_EDIT_LOADOUT_3,
        IDC_BUTTON_EDIT_LOADOUT_4,
        IDC_BUTTON_EDIT_LOADOUT_5,
        IDC_BUTTON_EDIT_LOADOUT_6,
        IDC_BUTTON_EDIT_LOADOUT_7,
        IDC_BUTTON_EDIT_LOADOUT_8,
        IDC_BUTTON_EDIT_LOADOUT_9,
        IDC_BUTTON_EDIT_LOADOUT_10,
        IDC_BUTTON_EDIT_LOADOUT_11,
        IDC_BUTTON_EDIT_LOADOUT_12,
        IDC_BACKGROUND_EDIT_LOADOUT_1,
        IDC_BACKGROUND_EDIT_LOADOUT_2,
        IDC_BACKGROUND_EDIT_LOADOUT_3,
        IDC_BACKGROUND_EDIT_LOADOUT_4,
        IDC_BACKGROUND_EDIT_LOADOUT_5,
        IDC_BACKGROUND_EDIT_LOADOUT_6,
        IDC_BACKGROUND_EDIT_LOADOUT_7,
        IDC_BACKGROUND_EDIT_LOADOUT_8,
        IDC_BACKGROUND_EDIT_LOADOUT_9,
        IDC_BACKGROUND_EDIT_LOADOUT_10,
        IDC_BACKGROUND_EDIT_LOADOUT_11,
        IDC_BACKGROUND_EDIT_LOADOUT_12,
        IDC_ICON_EDIT_LOADOUT_1,
        IDC_ICON_EDIT_LOADOUT_2,
        IDC_ICON_EDIT_LOADOUT_3,
        IDC_ICON_EDIT_LOADOUT_4,
        IDC_ICON_EDIT_LOADOUT_5,
        IDC_ICON_EDIT_LOADOUT_6,
        IDC_ICON_EDIT_LOADOUT_7,
        IDC_ICON_EDIT_LOADOUT_8,
        IDC_ICON_EDIT_LOADOUT_9,
        IDC_ICON_EDIT_LOADOUT_10,
        IDC_ICON_EDIT_LOADOUT_11,
        IDC_ICON_EDIT_LOADOUT_12,
        IDC_BUTTON_EDIT_BACKPACK_1,
        IDC_BUTTON_EDIT_BACKPACK_2,
        IDC_BUTTON_EDIT_BACKPACK_3,
        IDC_BUTTON_EDIT_BACKPACK_4,
        IDC_BUTTON_EDIT_BACKPACK_5,
        IDC_BUTTON_EDIT_BACKPACK_6,
        IDC_BUTTON_EDIT_BACKPACK_7,
        IDC_BUTTON_EDIT_BACKPACK_8,
        IDC_BUTTON_EDIT_BACKPACK_9,
        IDC_BUTTON_EDIT_BACKPACK_10,
        IDC_BUTTON_EDIT_BACKPACK_11,
        IDC_BUTTON_EDIT_BACKPACK_12,
        IDC_BACKGROUND_EDIT_BACKPACK_1,
        IDC_BACKGROUND_EDIT_BACKPACK_2,
        IDC_BACKGROUND_EDIT_BACKPACK_3,
        IDC_BACKGROUND_EDIT_BACKPACK_4,
        IDC_BACKGROUND_EDIT_BACKPACK_5,
        IDC_BACKGROUND_EDIT_BACKPACK_6,
        IDC_BACKGROUND_EDIT_BACKPACK_7,
        IDC_BACKGROUND_EDIT_BACKPACK_8,
        IDC_BACKGROUND_EDIT_BACKPACK_9,
        IDC_BACKGROUND_EDIT_BACKPACK_10,
        IDC_BACKGROUND_EDIT_BACKPACK_11,
        IDC_BACKGROUND_EDIT_BACKPACK_12,
        IDC_ICON_EDIT_BACKPACK_1,
        IDC_ICON_EDIT_BACKPACK_2,
        IDC_ICON_EDIT_BACKPACK_3,
        IDC_ICON_EDIT_BACKPACK_4,
        IDC_ICON_EDIT_BACKPACK_5,
        IDC_ICON_EDIT_BACKPACK_6,
        IDC_ICON_EDIT_BACKPACK_7,
        IDC_ICON_EDIT_BACKPACK_8,
        IDC_ICON_EDIT_BACKPACK_9,
        IDC_ICON_EDIT_BACKPACK_10,
        IDC_ICON_EDIT_BACKPACK_11,
        IDC_ICON_EDIT_BACKPACK_12
    ];
};
