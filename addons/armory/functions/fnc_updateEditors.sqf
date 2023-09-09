#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Saves the uids that can edit the given loadout.
 *
 *  Parameter(s):
 *      0: STRING - Equipment name
 *      1: ARRAY/STRING - Editor UIDs. Format: ["00000000000000000",...]
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      ["enhanced", ["00000000000000000"]] call mts_armory_fnc_saveEditors
 *
 */

private _params = params [["_equipmentName", "", [""]], ["_editors", [], [[],""]]];
TRACE_2("",_equipmentName,_editors);

if (_editors isEqualType "") then {
    //parseSimpleArray is not suiteable, because to many user input error can occur and <null> values will exist in array
    _editors = call compile _editors;
    TRACE_1("parsedEditors",_editors);
};

private _checkEditors = false;

{
    if !(_x isEqualType "") then {
        _checkEditors = true;
    };
} count _editors;

CHECK(!GVAR(initialized) || !_params || _equipmentName isEqualTo "" || ((_editors param [ARR_2(0,"")]) isEqualTo "") || _checkEditors);
CHECK(!isDedicated && !GVAR(cba_settings_playerDBConnection));

private _equipmentArray = GVAR(equipment) getVariable [_equipmentName, []];
private _equipmentID = _equipmentArray param [3, 0];

_equipmentArray set [4, _editors];
GVAR(equipment) setVariable [_equipmentName, _equipmentArray, true];

[GVAR(sessionID), "updateEditors", _editors, _equipmentID] call DB_SET;
