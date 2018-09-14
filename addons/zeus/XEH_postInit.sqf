#include "script_component.hpp"

CHECK(!hasinterface);

call FUNC(ACRESpectatorMode);
call FUNC(moduleShowProjectiles);
call FUNC(moduleArtillery);
call FUNC(moduleUnflipVehicle);
call FUNC(moduleForgetTarget);
call FUNC(moduleRevealTarget);
call FUNC(moduleTargetKnowledge);

#include "initKeybinds.hpp"
