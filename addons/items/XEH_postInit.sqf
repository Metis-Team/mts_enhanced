#include "script_component.hpp"

[QGVAR(miclic), "InitPost", {
    _this call FUNC(addMiclicAction);
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

CHECK(!hasinterface);

GVAR(pickupItemActionCounter) = 0;

GVAR(isPlacing) = PLACE_CANCEL;
["ace_interactMenuOpened", {GVAR(isPlacing) = PLACE_CANCEL;}] call CBA_fnc_addEventHandler;

call FUNC(addFlagACEActions);
call FUNC(addMarkerACEActions);
