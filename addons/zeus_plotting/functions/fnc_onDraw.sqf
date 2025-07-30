#include "script_component.hpp"
/*
 * Author: Timi007
 * Handles drawing the plots on the Zeus map. Is only called when map is open.
 *
 * Arguments:
 * 0: Zeus map <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_ctrlMap] call mts_zeus_plotting_fnc_onDraw
 *
 * Public: No
 */

params ["_ctrlMap"];

if (dialog || {call zen_common_fnc_isInScreenshotMode}) exitWith {}; // Dialog is open or HUD is hidden

[values GVAR(plots), GVAR(activePlot), _ctrlMap] call FUNC(drawPlots);
