#include "script_component.hpp"

CHECK(!hasinterface);

GVAR(isPlacing) = PLACE_CANCEL;
["ace_interactMenuOpened", {GVAR(isPlacing) = PLACE_CANCEL;}] call CBA_fnc_addEventHandler;

call FUNC(addACEActions);
