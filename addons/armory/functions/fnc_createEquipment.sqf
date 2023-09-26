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
 *      3: OBJECT - Object to add action for new equipment (optional)
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      ["enhanced", ["00000000000000000"]] call mts_armory_fnc_createEquipment
 *
 */

private _argsSuccessfullyParsed = params [["_equipmentName", "", [""]], ["_editors", [], [[],""]], ["_object", objNull, [objNull]]];
TRACE_4("",_equipmentName,_editors,_object, _argsSuccessfullyParsed);

if (_editors isEqualType "") then {
    _editors = parseSimpleArray _editors;
};

CHECK(!GVAR(initialized) || _equipmentName isEqualTo "" || ((_editors param [ARR_2(0,"")]) isEqualTo ""));
CHECK(!isDedicated && !(isServer && GVAR(allowPlayerDBConnection)));

[GVAR(sessionID), "insertEquipment", _equipmentName, _editors] call DB_SET;

if (!isNull _object) then {
    [{
        params ["_equipmentName", "_object"];
            [QGVAR(addAction), [_equipmentName, _object]] call CBA_fnc_globalEventJIP;
    }, [_equipmentName, _object]] call CBA_fnc_execNextFrame;
};
