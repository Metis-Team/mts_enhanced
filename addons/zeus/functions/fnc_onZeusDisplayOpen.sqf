#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Function triggered every time the curator display is opened.
 *
 *  Parameter(s):
 *      0: DISPLAY - Opened curator display.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [findDisplay 312] call mts_zeus_fnc_onZeusDisplayOpen
 *
 */

params ["_display"];

CHECK(!GVAR(enableACEUnconsciousIcon));

call FUNC(initDrawIconEH);
