#include "script_component.hpp"

CHECK(!hasInterface);

params ["_display"];

_display displayAddEventHandler ["MouseZChanged", {
    params ["", "_scroll"];
    [_scroll] call FUNC(handleScrollWheel);
}];

_display displayAddEventHandler ["MouseButtonDown", {
    params ["", "_button"];
    CHECKRET(GVAR(isPlacing) != PLACE_WAITING, false);
    CHECKRET(_button != 1, false); //1 = Left mouse button
    GVAR(isPlacing) = PLACE_CANCEL;
}];
