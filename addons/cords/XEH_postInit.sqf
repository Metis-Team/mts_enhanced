#include "script_component.hpp"

if (hasInterface && {"PBW_German_Uniform" call ace_common_fnc_isModLoaded}) then {
    INFO("PBW is loaded. Enabling ACE actions.");

    call FUNC(addCordsToAce);
    call FUNC(addMajorToAce);
};
