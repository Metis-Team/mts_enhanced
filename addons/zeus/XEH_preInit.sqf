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

GVAR(howitzerShellsCache) = +(uiNamespace getVariable [QGVAR(howitzerShellsCache), []]);
GVAR(mortarShellsCache) = +(uiNamespace getVariable [QGVAR(mortarShellsCache), []]);

GVAR(artilleryShellsNameCache) = (GVAR(howitzerShellsCache) apply {_x select [1, 3]}) + (GVAR(mortarShellsCache) apply {_x select [1, 3]});
GVAR(artilleryShellsAmmoCache) = (GVAR(howitzerShellsCache) apply {_x select 2}) + (GVAR(mortarShellsCache) apply {_x select 2});
