#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Get the placeable markers in the player's inventory.
 *
 *  Parameter(s):
 *      0: OBJECT - Player
 *
 *  Returns:
 *      ARRAY - Markers
 *
 *  Example:
 *      [player] call mts_items_fnc_getMarkers
 *
 */

params ["_player"];

(_player call ace_common_fnc_uniqueItems) arrayIntersect keys GVAR(markerCache)
