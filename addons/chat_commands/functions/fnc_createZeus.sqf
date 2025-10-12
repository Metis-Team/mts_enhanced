#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Create Zeus module and assign it to the unit.
 *
 *  Parameter(s):
 *      0: OBJECT - Unit to promote to Zeus.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [player] call mts_chat_commands_fnc_createZeus
 *
 */

params [["_unit", objNull, [objNull]]];

if (isNull _unit || {!isNull getAssignedCuratorLogic _unit}) exitWith {};

// Cleanup on disconnect
if (isNil QGVAR(createZeusDC)) then {
    GVAR(createZeusDC) = addMissionEventHandler ["HandleDisconnect", {
        params ["", "", "_owner"];

        private _curatorVar = format [QGVAR(zeus_%1), _owner];
        private _curator = missionNamespace getVariable _curatorVar;

        if (!isNil "_curator") then {
            if (!isNull _curator) then {
                unassignCurator _curator;
                deleteVehicle _curator;
            };
            missionNamespace setVariable [_curatorVar, nil];
        };
    }];
};

private _owner = ["#adminLogged", getPlayerUID _unit] select isMultiplayer;
private _group = createGroup [sideLogic, true];
private _curator = _group createUnit ["ModuleCurator_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
missionNamespace setVariable [format [QGVAR(zeus_%1), _owner], _curator];

_curator setVariable ["Addons", 3, true];
_curator setVariable ["BIS_fnc_initModules_disableAutoActivation", false];

_curator addCuratorEditableObjects [(allMissionObjects "" - entities [["Logic"], []]), true];
_unit assignCurator _curator;

[QEGVAR(common,hint), [LSTRING(zeusCreated)], _unit] call CBA_fnc_targetEvent;
