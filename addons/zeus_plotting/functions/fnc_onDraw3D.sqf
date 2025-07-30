#include "script_component.hpp"
/*
 * Author: Timi007
 * Handles drawing the plots in Zeus 3D.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call mts_zeus_plotting_fnc_onDraw3D
 *
 * Public: No
 */

if (
    isNull (findDisplay IDD_RSCDISPLAYCURATOR)  // We are in not Zeus
    || {!isNull (findDisplay IDD_INTERRUPT)}    // Pause menu is opened
    || {dialog}                                 // We have a dialog open
    || {call zen_common_fnc_isInScreenshotMode}  // HUD is hidden
) exitWith {};

[values GVAR(plots), GVAR(activePlot)] call FUNC(drawPlots);
