#include "script_component.hpp"

if (GVAR(PBWLoaded)) then {
    INFO("PBW is loaded. Enabling ACE actions.");

    call FUNC(addCordsToAce);
    call FUNC(addMajorToAce);
};
