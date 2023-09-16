#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Equips backpack to player.
 *
 *  Parameter(s):
 *      0: STRING - Equipment name
 *      1: STRING - Backpack name
 *
 *  Returns:
 *      None
 *
 *  Example:
 *      ["323","EEH-B"] call mts_armory_fnc_equipBackpack
 *
 */

private _params = params [["_equipmentName", "", [""]], ["_backpackName", "", [""]]];
TRACE_3("",_equipmentName,_backpackName,_params);

CHECK(!GVAR(initialized) || !_params);

private _equipmentNamespaces = GVAR(equipment) getVariable [_equipmentName, []];

if (_equipmentNamespaces isEqualTo []) exitWith {
    LOG_1("Equipment '%1' not in namespace. Will be initialized.",_equipmentName);
    [QGVAR(initEquipment), [player, QGVAR(equipBackpack), [_equipmentName, _backpackName]]] call CBA_fnc_serverEvent;
};

_equipmentNamespaces params ["", "_backpackNamespace"];

private _backpack = _backpackNamespace getVariable [_backpackName, []];
CHECKRET(_backpack isEqualTo [], WARNING_1("Backpack '%1' not available!", _backpackName));

_backpack params ["", "", "_class", "_items"];

removeBackpack player;
player addBackpack _class;

{
    player addItemToBackpack _x;
} count _items;
