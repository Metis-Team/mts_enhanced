#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Handles the flag object height.
 *
 *  Parameter(s):
 *      0: NUMBER - Scroll amount
 *
 *  Returns:
 *       BOOLEAN - Handled
 *
 *  Example:
 *      [5] call mts_flags_fnc_handleScrollWheel
 *
 */

params [["_scrollAmount", 0, [0]]];

if (GVAR(isPlacing) isNotEqualTo PLACE_WAITING) exitWith {
    false
};

// Move object height 10cm per scroll
GVAR(objectHeight) = GVAR(objectHeight) + (_scrollAmount * 0.1);

// Clamp height between MIN_HEIGHT and MAX_HEIGHT
GVAR(objectHeight) = (MIN_HEIGHT max (GVAR(objectHeight) min MAX_HEIGHT));

true
