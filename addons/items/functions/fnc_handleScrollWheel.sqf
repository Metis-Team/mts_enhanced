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
#include "script_component.hpp"

params ["_scrollAmount"];

CHECKRET(GVAR(isPlacing) != PLACE_WAITING, false);

//move object height 10cm per scroll
GVAR(objectHeight) = GVAR(objectHeight) + (_scrollAmount * 0.1);

if (GVAR(objectHeight) < MIN_HEIGHT) then {
    GVAR(objectHeight) = MIN_HEIGHT;
};

if (GVAR(objectHeight) > MAX_HEIGHT) then {
    GVAR(objectHeight) = MAX_HEIGHT;
};

true
