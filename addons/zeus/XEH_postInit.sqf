#include "script_component.hpp"


[QGVAR(revealTarget), {
    params ["_toUnits", "_target"];

    {
        _x reveal _target;
    } forEach _toUnits;

    TRACE_1("revealTarget", _this);
}] call CBA_fnc_addEventHandler;

[QGVAR(forgetTarget), {
    params ["_toUnits", "_target"];

    {
        _x forgetTarget _target;
    } forEach _toUnits;

    TRACE_1("forgetTarget", _this);
}] call CBA_fnc_addEventHandler;

CHECK(!hasinterface);

GVAR(moduleDestination_running) = false;

player addEventHandler ["killed", {
    params ["_unit"];
    [QGVAR(killed), [_unit, false]] call CBA_fnc_globalEvent;
}];

call FUNC(moduleArtillery);
call FUNC(moduleUnflipVehicle);
call FUNC(moduleForgetTarget);
call FUNC(moduleRevealTarget);
call FUNC(moduleTargetKnowledge);

call FUNC(contextMeasureDistance);

#include "initKeybinds.hpp"
