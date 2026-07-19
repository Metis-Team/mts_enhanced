#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Creates Metis markers from given data.
 *
 *  Parameter(s):
 *      0: ARRAY - User Metis markers.
 *          0: ARRAY - Position.
 *          1: ARRAY - Marker configuration..
 *          2: NUMBER - Scale.
 *          3: NUMBER - Alpha.
 *
 *  Returns:
 *      ARRAY - Marker prefixes of the created markers.
 *
 *  Example:
 *      [_markers] call mts_common_fnc_createMtsMarkers
 *
 */

params ["_markers"];

if !(["mts_markers"] call FUNC(isModLoaded)) exitWith {[]};

private _createdMarkers = [];
{
    _x params ["_pos", "_config", "_scale", "_alpha"];

    private _marker = [_pos, -10, true, _config, _scale, _alpha] call mts_markers_fnc_createMarker;
    _createdMarkers pushBack _marker;
} forEach _markers;

_createdMarkers
