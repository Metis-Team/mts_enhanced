#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Creates user markers from given data.
 *
 *  Parameter(s):
 *      0: ARRAY - User markers.
 *          0: ARRAY - Position.
 *          1: STRING - Type.
 *          2: STRING - Shape.
 *          3: ARRAY - Polyline.
 *          4: NUMBER - Direction.
 *          5: NUMBER - Alpha.
 *          8: STRING - Text.
 *          6: ARRAY - Color.
 *          7: ARRAY - Size.
 *
 *  Returns:
 *      ARRAY - Marker names of the created markers.
 *
 *  Example:
 *      [[[100, 100], "b_air", "ICON", [], 0, 1, "Hello", [0, 0, 0, 1], [1, 1]]] call mts_common_fnc_createMarkers
 *
 */

params ["_markers"];

private _markerCount = count allMapMarkers;
private _createdMarkers = [];
{
    _x params ["_pos", "_type", "_shape", "_polyline", "_dir", "_alpha", "_text", "_color", "_size"];

    private _name = format ["_USER_DEFINED #%1/%2/-1", getPlayerID player, _markerCount + _forEachIndex];
    private _marker = createMarker [_name, _pos];
    _marker setMarkerTypeLocal _type;
    _marker setMarkerShapeLocal _shape;
    if (_shape isEqualTo "POLYLINE") then {
        _marker setMarkerPolylineLocal _polyline;
    };
    _marker setMarkerDirLocal _dir;
    _marker setMarkerAlphaLocal _alpha;
    _marker setMarkerTextLocal _text;
    _marker setMarkerColorLocal _color;
    _marker setMarkerSize _size; // Must be not local to broadcast globally

    _createdMarkers pushBack _marker;
} forEach _markers;

_createdMarkers
