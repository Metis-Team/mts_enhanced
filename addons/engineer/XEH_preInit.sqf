#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

ADDON = true;

[QGVAR(miclic_base), "InitPost", {
    _this call FUNC(addIgniteMiclicAction);
}, nil, nil, true] call CBA_fnc_addClassEventHandler;
