#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Wrapper for ACE isModLoaded function.
 *      If ACE function is not available our own implementation is used.
 *      ACE function is preferred because of higher cache hit rate.
 *
 *  Parameter(s):
 *      0: STRING - Classname of the mod in CfgPatches.
 *
 *  Returns:
 *      BOOL - If modification is loaded
 *
 *  Example:
 *      ["ace_common"] call mts_common_fnc_isModLoaded
 *
 */

params [["_modName", "", [""]]];

if (!isNil "ace_common_fnc_isModLoaded") then {
    [_modName] call ace_common_fnc_isModLoaded
} else {
    GVAR(isModLoadedCache) getOrDefaultCall [toLowerANSI _modName, {isClass (configFile >> "CfgPatches" >> _modName)}, true]
};
