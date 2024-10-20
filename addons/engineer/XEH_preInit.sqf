#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

ADDON = true;

["B_APC_Tracked_01_CRV_F", "InitPost", {
    _this call FUNC(initMineClearingActions);
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["gm_BPz2a0_base", "InitPost", {
    _this call FUNC(initMineClearingActions);
}, nil, nil, true] call CBA_fnc_addClassEventHandler;
