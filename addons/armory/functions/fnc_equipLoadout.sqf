/**
 *  Author: PhILoX
 *
 *  Description:
 *      Equips loadout and sets ace medic or ace engineer to player.
 *
 *  Parameter(s):
 *      0: STRING - Equipment name
 *      1: STRING - Loadout name
 *
 *  Returns:
 *      None
 *
 *  Example:
 *      ["323","EEH-B"] call mts_armory_fnc_equipLoadout
 *
 */
#include "script_component.hpp"

private _params = params [["_equipmentName", "", [""]], ["_loadoutName", "", [""]]];
TRACE_3("",_equipmentName,_loadoutName,_params);

CHECK(!GVAR(initialized) || !_params);

private _equipmentNamespaces = GVAR(equipment) getVariable [_equipmentName, []];

if (_equipmentNamespaces isEqualTo []) exitWith {
    LOG("Equipment not in Namespace");
    [QGVAR(initEquipment), [player, QGVAR(equipLoadout), [_equipmentName, _loadoutName]]] call CBA_fnc_serverEvent;
};

_equipmentNamespaces params ["_loadoutNamespace"];

(_loadoutNamespace getVariable [_loadoutName, []]) params ["", "", "_loadout", "_ace_medic", "_ace_engineer"];

player setUnitLoadout [_loadout, true];
player setVariable ["ace_medical_medicclass", _ace_medic, true];
player setVariable ["ace_isengineer", _ace_engineer, true];
