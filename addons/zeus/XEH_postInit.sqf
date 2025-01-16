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
    [QGVAR(execArtyStrike), LINKFUNC(execArtyStrike)] call CBA_fnc_addEventHandler;
    [QGVAR(waitAndExecAirburst), LINKFUNC(waitAndExecAirburst)] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    [QGVAR(visualizeArtyTargetArea), LINKFUNC(visualizeArtyTargetArea)] call CBA_fnc_addEventHandler;

    [QGVAR(fireMissionBegin), {
        if (isNull curatorCamera) exitWith {};
        [LLSTRING(artillery_fireMissionBegin)] call zen_common_fnc_showMessage;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(fireMissionImpact), {
        if (isNull curatorCamera) exitWith {};
        [LLSTRING(artillery_fireMissionImpact)] call zen_common_fnc_showMessage;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(fireMissionComplete), {
        if (isNull curatorCamera) exitWith {};
        [LLSTRING(artillery_fireMissionComplete)] call zen_common_fnc_showMessage;
    }] call CBA_fnc_addEventHandler;

    GVAR(moduleDestination_running) = false;

    GVAR(3DENComments_drawEHAdded) = false;
    GVAR(3DENComments_data) = getMissionConfigValue [QGVAR(3denComments), []];
    TRACE_1("3DEN Comments",GVAR(3DENComments_data));

    GVAR(ACEIcon_drawEHAdded) = false;

    call FUNC(moduleArtillery);
    call FUNC(moduleUnflipVehicle);
    call FUNC(moduleForgetTarget);
    call FUNC(moduleRevealTarget);
    call FUNC(moduleTargetKnowledge);
    call FUNC(moduleSuicideDrone);

    call FUNC(contextMeasureDistance);
};

