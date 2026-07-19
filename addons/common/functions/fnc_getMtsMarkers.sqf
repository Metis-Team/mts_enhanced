#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Get all user Metis marker if mod is loaded.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      ARRAY - User Metis markers.
 *
 *  Example:
 *      [] call mts_common_fnc_getMtsMarkers
 *
 */

if !(["mts_markers"] call FUNC(isModLoaded)) exitWith {[]};

private _userMarkers = [false] call mts_markers_fnc_getAllMarkers;

_userMarkers apply {
    [
        [_x] call mts_markers_fnc_getMarkerPos,
        [_x] call mts_markers_fnc_getMarkerConfig,
        [_x] call mts_markers_fnc_getMarkerScale,
        [_x] call mts_markers_fnc_getMarkerAlpha
    ]
}
