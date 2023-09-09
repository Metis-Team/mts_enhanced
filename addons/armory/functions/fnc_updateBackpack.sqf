#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Updates given Backpack in database
 *
 *  Parameter(s):
 *      0: STRING - Equipment name
 *      1: STRING - Backpack name:
 *                      - for the purpose of changing the name: new name (it will also update the backpack itself)
 *                      - only update the backpack not the name: current name
 *                      - for deleting the backpack: empty string ""
 *                      - for insert into database: new name
 *      2: STRING - Backpack name:
 *                      - for the purpose of changing the name: previos name (it will also update the backpack itself)
 *                      - only update the backpack not the name: current name
 *                      - for deleting the backpack: current name
 *                      - for insert into database: empty string ""
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      The namespace with the corresponding name must exist beforehand.
 *      ["323", "MG1", "MG-1"] call mts_armory_fnc_updateBackpack
 *
 */

private _params = params [["_equipmentName", "", [""]], ["_name", "", [""]], ["_oldName", "", [""]]];

CHECK(!GVAR(initialized) || !_params);
CHECK(!isDedicated && !GVAR(cba_settings_playerDBConnection));

(GVAR(equipment) getVariable [_equipmentName, []]) params ["", "_backpackNamespace", "", "_equipmentID"];
_backpackNamespace getVariable [_name, []] params ["", "_idc", "_class", "_items"];
TRACE_7("updateBackpack",_equipmentName, _equipmentID,_name,_oldName,_idc,_class,_items);


if (_oldName isEqualTo "") exitWith {
    [GVAR(sessionID), "insertBackpack", _name, _idc, _class, _items, _equipmentID] call DB_SET;
};
if (_name isEqualTo "") exitWith {
    [GVAR(sessionID), "removeBackpack", _oldName, _equipmentID] call DB_SET;
};
[GVAR(sessionID), "updateBackpack", _name, _idc, _class, _items, _oldName, _equipmentID] call DB_SET;
