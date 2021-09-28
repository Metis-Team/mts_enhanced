#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *     Checks if given mods (CfgPatches name) are loaded.
 *
 *  Parameter(s):
 *      0: ARRAY - Mod names in CfgPatches.
 *
 *  Returns:
 *      BOOLEAN - All mods are loaded.
 *
 *  Example:
 *      [["mts_main"]] call mts_common_fnc_areModsLoaded
 *      [["mts_main", "mts_common"]] call mts_common_fnc_areModsLoaded
 *
 */

params [["_mods", [], [[]]]];

CHECKRET(_mods isEqualTo [], false);

(_mods findIf {!isClass (configFile >> "CfgPatches" >> _x)}) isEqualTo -1
