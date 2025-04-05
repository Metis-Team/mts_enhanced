#include "script_component.hpp"

if (hasInterface && GVAR(PBWLoaded)) then {
    INFO("PBW is loaded. Enabling ACE actions.");

    call FUNC(addMajorToAce);
};
