#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Returns all user markers
 *
 *  Parameter(s):
 *      None
 *
 *  Returns:
 *      ARRAY - User markers
 *
 *  Example:
 *      [] call mts_common_fnc_getMarkers
 *
 */

private _userMarkers = allMapMarkers select {"_USER_DEFINED" in _x};

_userMarkers apply {
    [
        markerPos _x,
        markerType _x,
        markerShape _x,
        markerPolyline _x,
        markerDir _x,
        markerAlpha _x,
        markerText _x,
        markerColor _x,
        markerSize _x
    ]
}
