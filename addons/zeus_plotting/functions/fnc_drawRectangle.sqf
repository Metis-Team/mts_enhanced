#include "script_component.hpp"
/*
 * Authors: Timi007
 * Draws a rectangle plot in 3D or on the map. Must be called every frame.
 *
 * Arguments:
 * 0: Start position ASL or attached object <ARRAY or OBJECT>
 * 1: End position ASL or attached object <ARRAY or OBJECT>
 * 2: Visual properties <ARRAY>
 *      0: Icon <STRING>
 *      1: Color RGBA <ARRAY>
 *      2: Scale <NUMBER>
 *      3: Angle <NUMBER>
 *      4: Line width <NUMBER>
 * 3: Formatters <ARRAY>
 *      0: Distance formatter <CODE>
 * 4: Additional arguments <ARRAY> (default: [])
 * 5: Map control <CONTROL> (default: Draw in 3D)
 *
 * Return Value:
 * None
 *
 * Example:
 * [[0, 0, 0], [100, 100, 0], ["", [1, 0, 0, 1], 1, 0, 5], [{_this toFixed 0}]] call mts_zeus_plotting_fnc_drawRectangle
 *
 * Public: No
 */

params ["_startPosOrObj", "_endPosOrObj", "_visualProperties", "_formatters", ["_args", [], [[]]], ["_ctrlMap", controlNull, [controlNull]]];
_visualProperties params ["_icon", "_color", "_scale", "_angle", "_lineWidth"];

private _startPos = _startPosOrObj;
if (_startPosOrObj isEqualType objNull) then {
    _startPos = getPosASLVisual _startPosOrObj;
};

private _endPos = _endPosOrObj;
if (_endPosOrObj isEqualType objNull) then {
    _endPos = getPosASLVisual _endPosOrObj;
};

private _offset = _endPos vectorDiff _startPos;
_offset params ["_a", "_b", "_c"];

private _fnc_format = {
    params ["_offset", "_formatters"];
    _offset params ["_a", "_b", "_c"];
    _formatters params ["_fnc_formatDistance"];

    format ["X: %1 - Y: %2 - Z: %3", _a call _fnc_formatDistance, _b call _fnc_formatDistance, _c call _fnc_formatDistance]
};

if (isNull _ctrlMap) then { // 3D
    private _camPos = getPosASL curatorCamera;

    if (CAN_RENDER_ICON(_camPos,_startPos)) then {
        drawIcon3D [_icon, _color, ASLToAGL _startPos, _scale, _scale, _angle];
    };

    _startPos params ["_x1", "_y1", "_z1"];
    _endPos params ["_x2", "_y2", "_z2"];

    private _edges = if ((abs (_z2 - _z1)) > CUBOID_HEIGHT_THRESHOLD) then {
        [
            [[_x1, _y1, _z1], [_x2, _y1, _z1], [_x2, _y2, _z1], [_x1, _y2, _z1], [_x1, _y1, _z1]], // Rectangle same height as start pos
            [[_x1, _y1, _z2], [_x2, _y1, _z2], [_x2, _y2, _z2], [_x1, _y2, _z2], [_x1, _y1, _z2]], // Rectangle same height as end pos
            // Connections from start to end height
            [[_x1, _y1, _z1], [_x1, _y1, _z2]],
            [[_x2, _y1, _z1], [_x2, _y1, _z2]],
            [[_x2, _y2, _z1], [_x2, _y2, _z2]],
            [[_x1, _y2, _z1], [_x1, _y2, _z2]]
        ]
    } else {
        // Don't draw cuboid if height difference is small
        [[[_x1, _y1, _z1], [_x2, _y1, _z1], [_x2, _y2, _z1], [_x1, _y2, _z1], [_x1, _y1, _z1]]]
    };

    {
        for "_i" from 0 to (count _x - 2) do {
            private _pos1 = _x select _i;
            private _pos2 = _x select (_i + 1);

            if (CAN_RENDER_LINE(_camPos,_pos1,_pos2)) then {
                drawLine3D [ASLToAGL _pos1, ASLToAGL _pos2, _color, _lineWidth];
            };
        };
    } forEach _edges;

    if (CAN_RENDER_ICON(_camPos,_endPos)) then {
        drawIcon3D [_icon, _color, ASLToAGL _endPos, _scale, _scale, _angle, [_offset, _formatters] call _fnc_format];
    };
} else { // Map
    _ctrlMap drawIcon [_icon, _color, _startPos, _scale, _scale, _angle];
    private _center = (_startPos vectorAdd _endPos) vectorMultiply 0.5;
    _ctrlMap drawRectangle [_center, _a / 2, _b / 2, 0, _color, ""];
    _ctrlMap drawIcon [_icon, _color, _endPos, _scale, _scale, _angle, [_offset, _formatters] call _fnc_format];
};
