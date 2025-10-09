#include "script_component.hpp"

if (hasInterface) then {
    [QGVAR(hint), {
        params ["_message"];
        _message = if (isLocalized _message) then {localize _message} else {_message};
        hint _message;
    }] call CBA_fnc_addEventHandler;
};

if (isServer) then {
    [QGVAR(createZeus), LINKFUNC(createZeus)] call CBA_fnc_addEventHandler;
};

call FUNC(addChatCommands);
