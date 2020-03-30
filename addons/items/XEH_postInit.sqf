#include "script_component.hpp"

CHECK(!hasinterface);

GVAR(pickupItemActionCounter) = 0;

GVAR(isPlacing) = PLACE_CANCEL;
["ace_interactMenuOpened", {GVAR(isPlacing) = PLACE_CANCEL;}] call CBA_fnc_addEventHandler;

call FUNC(addFlagACEActions);
call FUNC(addMarkerACEActions);
