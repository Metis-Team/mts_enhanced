#include "script_component.hpp"

// Print version to rpt log
private _version = getText (configFile >> "CfgPatches" >> QUOTE(ADDON) >> "versionStr");
INFO_1("Metis Enhanced version: %1.", _version);
