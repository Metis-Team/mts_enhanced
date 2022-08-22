#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

// Print version to rpt log
private _version = getText (configFile >> "CfgPatches" >> "mts_main" >> "versionStr");
INFO_1("Metis Enhanced version: %1.", _version);

#include "initSettings.hpp"

ADDON = true;
