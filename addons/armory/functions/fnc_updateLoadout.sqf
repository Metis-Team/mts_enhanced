#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Updates given Loadout in database
 *
 *  Parameter(s):
 *      0: STRING - Equipment name
 *      1: STRING - Loadout name:
 *                      - for the purpose of changing the name: new name (it will also update the loadout itself)
 *                      - only update the loadout not the name: current name
 *                      - for deleting the loadout: empty string ""
 *                      - for insert into database: new name
 *      2: STRING - Loadout name:
 *                      - for the purpose of changing the name: previos name (it will also update the loadout itself)
 *                      - only update the loadout not the name: current name
 *                      - for deleting the loadout: current name
 *                      - for insert into database: empty string ""
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      The namespace with the corresponding name must exist beforehand.
 *      ["323", "MG1", "MG-1"] call mts_armory_fnc_updateLoadout
 *
 */

private _argsSuccessfullyParsed = params [["_equipmentName", "", [""]], ["_name", "", [""]], ["_oldName", "", [""]]];

CHECK(!GVAR(initialized) || !_argsSuccessfullyParsed);
CHECK(!isDedicated && !(isServer && GVAR(allowPlayerDBConnection)));

(GVAR(equipment) getVariable [_equipmentName, []]) params ["_loadoutNamespace", "", "", "_equipmentID"];
_loadoutNamespace getVariable [_name, []] params ["", "_idc", "_loadout", "_ace_medic", "_ace_engineer"];
TRACE_8("updateLoadout",_equipmentName,_equipmentID,_name,_oldName,_idc,_ace_medic,_ace_engineer,_loadout);

if (_oldName isEqualTo "") exitWith {
    [GVAR(sessionID), "insertLoadout", _name, _idc, _loadout, _ace_medic, _ace_engineer, _equipmentID] call DB_SET;
};
if (_name isEqualTo "") exitWith {
    [GVAR(sessionID), "removeLoadout", _oldName, _equipmentID] call DB_SET;
};
[GVAR(sessionID), "updateLoadout", _name, _idc, _loadout, _ace_medic, _ace_engineer, _oldName, _equipmentID] call DB_SET;
