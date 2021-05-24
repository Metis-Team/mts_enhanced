#include "script_component.hpp"


CHECK(!hasinterface);

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
