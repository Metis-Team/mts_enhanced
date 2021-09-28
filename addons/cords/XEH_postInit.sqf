#include "script_component.hpp"

if ([["PBW_German_Uniform", "PBW_German_Common"]] call EFUNC(commmon,areModsLoaded)) then {
    call FUNC(addCordsToAce);
    call FUNC(addMajorToAce);
};
