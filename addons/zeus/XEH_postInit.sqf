#include "script_component.hpp"


[QGVAR(revealTarget), {
    params ["_toUnits", "_target"];
    {_x reveal _target} forEach _toUnits;
}] call CBA_fnc_addEventHandler;

[QGVAR(forgetTarget), {
    params ["_toUnits", "_target"];
    {_x forgetTarget _target} forEach _toUnits;
}] call CBA_fnc_addEventHandler;

if (isServer) then {
    GVAR(nextTargetID) = 1;

    [QGVAR(initFireMission), LINKFUNC(initFireMission)] call CBA_fnc_addEventHandler;
    [QGVAR(execFireMission), LINKFUNC(execFireMission)] call CBA_fnc_addEventHandler;
    [QGVAR(waitAndExecAirburst), LINKFUNC(waitAndExecAirburst)] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    [QGVAR(visualizeArtyTargetArea), LINKFUNC(visualizeArtyTargetArea)] call CBA_fnc_addEventHandler;

    [QGVAR(fireMissionBegin), {
        if (isNull curatorCamera) exitWith {};
        private _id = ((_this select 0) select 0) getVariable [QGVAR(targetID), 0];
        [LLSTRING(artillery_fireMissionBegin), _id] call zen_common_fnc_showMessage;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(fireMissionImpact), {
        if (isNull curatorCamera) exitWith {};
        private _id = (_this select 0) getVariable [QGVAR(targetID), 0];
        [LLSTRING(artillery_fireMissionImpact), _id] call zen_common_fnc_showMessage;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(fireMissionComplete), {
        if (isNull curatorCamera) exitWith {};
        params ["_id", "_canceled"];
        TRACE_2("fireMissionComplete EH",_id,_canceled);

        if (_id <= 0) exitWith {};

        if (_canceled) then {
            [LLSTRING(artillery_fireMissionCanceled), _id] call zen_common_fnc_showMessage;
        } else {
            [LLSTRING(artillery_fireMissionComplete), _id] call zen_common_fnc_showMessage;
        };
    }] call CBA_fnc_addEventHandler;

    GVAR(moduleDestination_running) = false;

    GVAR(3DENComments_drawEHAdded) = false;
    GVAR(3DENComments_data) = getMissionConfigValue [QGVAR(3denComments), []];
    TRACE_1("3DEN Comments",GVAR(3DENComments_data));

    GVAR(ACEIcon_drawEHAdded) = false;

    call FUNC(moduleArtillery);
    call FUNC(moduleUnflipVehicle);
    call FUNC(moduleTargetKnowledge);
    call FUNC(moduleSuicideDrone);
};

