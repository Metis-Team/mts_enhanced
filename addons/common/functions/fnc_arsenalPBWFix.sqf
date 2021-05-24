#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Places PBW ranks back on uniform after leaving ACE arsenal.
 *
 *  Parameter(s):
 *      None
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      call mts_common_fnc_arsenalPBWFix
 *
 */

CHECK(!isClass (configFile >> "CfgPatches" >> "PBW_German_Uniform") || !hasinterface);

["ace_arsenal_displayClosed", {execvm "german_common\scripts\ranks\getKlappen.sqf"}] call CBA_fnc_addEventhandler; //for gods sake execvm :(
