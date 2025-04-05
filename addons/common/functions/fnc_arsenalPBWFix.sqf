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

if (!hasInterface || {!("PBW_German_Uniform" call ace_common_fnc_isModLoaded)}) exitWith {};

INFO("Applying patch to place PBW ranks back on uniform after leaving ACE arsenal.");

["ace_arsenal_displayClosed", {execVM "german_common\scripts\ranks\getKlappen.sqf"}] call CBA_fnc_addEventhandler; //for gods sake execVM :(
