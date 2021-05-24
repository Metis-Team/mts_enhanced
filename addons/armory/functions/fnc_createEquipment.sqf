#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Creates new Equipment entry in database.
 *
 *  Parameter(s):
 *      0: STRING - Equipment name
 *      1: ARRAY - Editor UIDs. Format: ["00000000000000000",...]
 *      2: BOOLEAN - if the equipment should be initialized after creation (optional)
 *      3: OBJECT - Object to add action (optional)
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      ["enhanced", ["00000000000000000"], true] call mts_armory_fnc_newEquipment
 *
 */

private _params = params [["_equipmentName", "", [""]], ["_editors", [], [[],""]], ["_initialize", false, [false]], ["_object", objNull, [objNull]]];
TRACE_4("",_equipmentName,_editors,_initialize,_object);

if (_editors isEqualType "") then {
    _editors = parseSimpleArray _editors;
};

CHECK(!GVAR(initialized) || !_params || _equipmentName isEqualTo "" || ((_editors param [ARR_2(0,"")]) isEqualTo "") || !SERVER_CHECK);

[GVAR(sessionID), "insertEquipment", _equipmentName, _editors] call DB_SET;

if (_initialize) then {
    [{
        params ["_equipmentName", "_object"];
        if ([_equipmentName] call FUNC(initEquipment)) then {
            [QGVAR(addAction), [_equipmentName, _object]] call CBA_fnc_globalEventJIP;
        };
    }, [_equipmentName, _object]] call CBA_fnc_execNextFrame;
};
