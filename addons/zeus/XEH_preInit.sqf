#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

ADDON = true;

#include "initSettings.hpp"
#include "initKeybinds.hpp"

// Cache charges for suicide drone
private _chargeCache = +(uiNamespace getVariable "zen_modules_minesCache");
_chargeCache params ["_configNames", "_displayNames"];

private _cfgVehicles = configFile >> "CfgVehicles";
_configNames = [
    "DemoCharge_Remote_Ammo_Scripted",
    "SatchelCharge_Remote_Ammo_Scripted"
] + _configNames;
_displayNames = [
    getText (_cfgVehicles >> "DemoCharge_F" >> "displayName"),
    getText (_cfgVehicles >> "SatchelCharge_F" >> "displayName")
] + _displayNames;
GVAR(chargeCache) = [_configNames, _displayNames];

// For 3DEN comments in Zeus
if (is3DEN) then {
    add3DENEventHandler ["OnMissionSave", {[false] call FUNC(on3DENMissionSave)}];
    add3DENEventHandler ["OnMissionAutosave", {[true] call FUNC(on3DENMissionSave)}];
};
