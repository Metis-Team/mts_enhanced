#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Saves all user markers to namespace
 *
 *  Parameter(s):
 *      0: NAMESPACE - Namespace where to save the markers to.
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      [profileNamespace] call mts_common_fnc_saveMarkers
 *
 */

params ["_namespace"];

private _userMarkers = allMapMarkers select {"_USER_DEFINED" in _x};

private _markers = _userMarkers apply {
    [
        markerPos _x,
        markerType _x,
        markerShape _x,
        markerPolyline _x,
        markerDir _x,
        markerAlpha _x,
        markerText _x,
        markerColor _x
    ]
};

_namespace setVariable [QGVAR(savedMarkersWorldName), worldName];
_namespace setVariable [QGVAR(savedMarkers), _markers];

if (_namespace isEqualTo profileNamespace) then {saveProfileNamespace};
if (_namespace isEqualTo missionProfileNamespace) then {saveMissionProfileNamespace};
