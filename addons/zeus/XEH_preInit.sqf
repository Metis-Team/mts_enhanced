#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

ADDON = true;

#include "initSettings.hpp"

// For 3DEN comments in Zeus
if (is3DEN) then {
    add3DENEventHandler ["OnMissionSave", {[false] call FUNC(on3DENMissionSave)}];
    add3DENEventHandler ["OnMissionAutosave", {[true] call FUNC(on3DENMissionSave)}];
};
