#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

call FUNC(compileCommands);

// Must be included after compileCommands
#include "initSettings.inc.sqf"

// Last created markers for undo action
GVAR(createdMarkers) = [];

ADDON = true;
