#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Visualize target area in Zeus.
 *
 *  Parameter(s):
 *      0: OBJECT - Target logic indicating center pos and angle of area.
 *      1: NUMBER - Width of target area.
 *      2: NUMBER - Depth of target area.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [_logic, 100, 50] call mts_zeus_fnc_visualizeArtyTargetArea
 *
 */

if (!hasInterface) exitWith {};

addMissionEventHandler ["Draw3D", {
    _thisArgs params ["_logic", "_width", "_depth"];

    if (isNull _logic) exitWith {
        removeMissionEventHandler [_thisEvent, _thisEventHandler];
    };

    private _zeusDisplay = findDisplay ZEUS_DISPLAY;
    if (isNull _zeusDisplay || !isNull (findDisplay PAUSE_MENU_DISPLAY)) exitWith {};
    if (ctrlShown (_zeusDisplay displayCtrl ZEUS_WATERMARK_CTRL)) exitWith {}; // HUD Hidden

    private _position = _logic modelToWorldVisual [0, 0, TARGET_AREA_HEIGHT];
    private _camPosition = ASLToAGL getPosASLVisual curatorCamera;
    if ((_position distance _camPosition) > TARGET_AREA_MAX_DISTANCE) exitWith {};

    // Copied and modified from zen_common_fnc_spawnLargeObject
    private _direction = vectorDirVisual _logic;
    _direction set [2, 0];
    _direction = vectorNormalized _direction;

    private _perpendicular = [0, 0, 1] vectorCrossProduct _direction;

    // Draw rectangle around helper object
    private _corner1 = _position vectorAdd (_direction vectorMultiply  _depth / 2) vectorAdd (_perpendicular vectorMultiply  _width / 2);
    private _corner2 = _position vectorAdd (_direction vectorMultiply -_depth / 2) vectorAdd (_perpendicular vectorMultiply  _width / 2);
    private _corner3 = _position vectorAdd (_direction vectorMultiply -_depth / 2) vectorAdd (_perpendicular vectorMultiply -_width / 2);
    private _corner4 = _position vectorAdd (_direction vectorMultiply  _depth / 2) vectorAdd (_perpendicular vectorMultiply -_width / 2);

    drawLine3D [_corner1, _corner2, TARGET_AREA_LINE_COLOR, TARGET_AREA_LINE_W];
    drawLine3D [_corner2, _corner3, TARGET_AREA_LINE_COLOR, TARGET_AREA_LINE_W];
    drawLine3D [_corner3, _corner4, TARGET_AREA_LINE_COLOR, TARGET_AREA_LINE_W];
    drawLine3D [_corner4, _corner1, TARGET_AREA_LINE_COLOR, TARGET_AREA_LINE_W];
}, _this];
