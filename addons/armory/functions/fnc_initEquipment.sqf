#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Initializes equipment (get equipment from database and prepare namespaces).
 *
 *  Parameter(s):
 *      0: STRING - Equipment name
 *
 *  Returns:
 *      BOOLEAN - Successfull/failed
 *
 *  Example:
 *      ["323"] call mts_armory_fnc_initEquipment
 *
 */

params [["_equipmentName", "", [""]]];
TRACE_1("", _equipmentName);

CHECKRET(!GVAR(initialized) || _equipmentName isEqualTo "" || !SERVER_CHECK,false);
CHECKRET(_equipmentName in GVAR(equipmentInitialized),true);

private _equipmentInfo = [GVAR(sessionID), "getEquipmentInfo", _equipmentName] call DB_GET;

if (_equipmentInfo isEqualTo []) exitWith {
    INFO(format [ARR_2(LLSTRING(error_EquipmentCategoryNotExists),_equipmentName)]);
    false
};

(_equipmentInfo select 0) params ["_equipmentID", "_editors", "_arsenal"];
TRACE_3("EquipmentInfo", _equipmentID, _editors, _arsenal);

private _loadoutNamespace = [true] call CBA_fnc_createNamespace;
private _backpackNamespace = [true] call CBA_fnc_createNamespace;

private _loadouts = [GVAR(sessionID), "getLoadouts", _equipmentID] call DB_GET;
private _backpacks = [GVAR(sessionID), "getBackpacks", _equipmentID] call DB_GET;

{
    _x params ["_equipmentName", "_idc", "_loadout", "_ace_medic", "_ace_engineer"];

    _loadoutNamespace setVariable [_equipmentName, [_equipmentName, _idc, _loadout, _ace_medic, _ace_engineer], true];
} count _loadouts;

{
    _x params ["_equipmentName", "_idc", "_class", "_items"];

    _backpackNamespace setVariable [_equipmentName, [_equipmentName, _idc, _class, _items], true];
} count _backpacks;

GVAR(equipment) setVariable [_equipmentName, [_loadoutNamespace, _backpackNamespace, _equipmentName, _equipmentID, _editors, _arsenal], true];

GVAR(equipmentInitialized) pushBackUnique _equipmentName;
TRACE_1("",GVAR(equipmentInitialized));
LOG_1("Equipment '%1' initialized",_equipmentName);
true
