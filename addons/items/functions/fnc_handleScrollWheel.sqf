#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Handles the object height.
 *
 *  Parameter(s):
 *      0: NUMBER - Scroll amount
 *
 *  Returns:
 *      BOOLEAN - Handled.
 *
 *  Example:
 *      [5] call mts_items_fnc_handleScrollWheel
 *
 */

params ["_scrollAmount"];

CHECKRET(GVAR(isPlacing) isNotEqualTo PLACE_WAITING, false);

//move object height 10cm per scroll
GVAR(objectHeight) = GVAR(objectHeight) + (_scrollAmount * 0.1);

// Clamp height between MIN_HEIGHT and MAX_HEIGHT
GVAR(objectHeight) = (MIN_HEIGHT max (GVAR(objectHeight) min MAX_HEIGHT));

true
