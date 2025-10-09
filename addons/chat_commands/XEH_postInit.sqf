#include "script_component.hpp"

if (isServer) then {
    [QGVAR(createZeus), LINKFUNC(createZeus)] call CBA_fnc_addEventHandler;
};

call FUNC(addChatCommands);
