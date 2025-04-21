#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Loads saved user markers from namespace
 *
 *  Parameter(s):
 *      0: NAMESPACE - Namespace where the saved markers are located.
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      [profileNamespace] call mts_common_fnc_loadMarkers
 *
 */

params ["_namespace"];

private _markers = _namespace getVariable [QGVAR(savedMarkers), []];

private _markerCount = count allMapMarkers;
{
    _x params ["_pos", "_type", "_shape", "_polyline", "_dir", "_alpha", "_text", "_color"];

    private _name = format ["_USER_DEFINED #%1/%2/-1", (getPlayerID player), _markerCount + _forEachIndex];
    private _marker = createMarker [_name, _pos];
    _marker setMarkerTypeLocal _type;
    _marker setMarkerShapeLocal _shape;
    if (_shape isEqualTo "POLYLINE") then {
        _marker setMarkerPolylineLocal _polyline;
    };
    _marker setMarkerDirLocal _dir;
    _marker setMarkerAlphaLocal _alpha;
    _marker setMarkerTextLocal _text;
    _marker setMarkerColor _color; // Must be not local to broadcast
} forEach _markers;
