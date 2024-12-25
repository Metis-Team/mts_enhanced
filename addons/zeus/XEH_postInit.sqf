#include "script_component.hpp"


[QGVAR(revealTarget), {
    params ["_toUnits", "_target"];

    {
        _x reveal _target;
    } forEach _toUnits;
}] call CBA_fnc_addEventHandler;

[QGVAR(forgetTarget), {
    params ["_toUnits", "_target"];

    {
        _x forgetTarget _target;
    } forEach _toUnits;
}] call CBA_fnc_addEventHandler;

if (isServer) then {
    [QGVAR(frago), {_this call ace_frag_fnc_frago}] call CBA_fnc_addEventHandler;
};

CHECK(!hasInterface);

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

#include "initKeybinds.hpp"
