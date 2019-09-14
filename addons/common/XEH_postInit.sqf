#include "script_component.hpp"

// Print version to rpt log
private _version = getText (configFile >> "CfgPatches" >> "mts_main" >> "versionStr");
INFO_1("Metis Enhanced is version %1.", _version);

call FUNC(addGrassCutter);
call FUNC(arsenalPBWFix);
call FUNC(addChatCommands);
