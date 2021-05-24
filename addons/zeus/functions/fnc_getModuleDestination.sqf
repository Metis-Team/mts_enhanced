#include "script_component.hpp"
/*
 *  Author: PabstMirror and Timi007
 *
 *  Description:
 *      Allows zeus to click to indicate a 3d position.
 *
 *  Parameter(s):
 *      0: The souce ASL position <ARRAY>
 *      1: Code to run when position is ready <CODE>
 *          - Code is passed
 *          0: Successful <BOOL>
 *          1: Souce Position ASL <ARRAY>
 *          2: Destination Position ASL <ARRAY>
 *          3: State of Shift <BOOL>
 *          4: State of Ctrl <BOOL>
 *          5: State of Alt <BOOL>
 *          6: Args from parameter 2 <ARRAY>
 *      2: Args which are passed to the code <ARRAY> (default: [])
 *      3: Text <STRING> (default: "")
 *      4: Icon image file <STRING> (default: "\a3\ui_f\data\IGUI\Cfg\Cursors\select_target_ca.paa")
 *      5: Icon color <ARRAY> (default: [1,0,0,1])
 *      6: Icon Angle <NUMBER> (default: 45)
 *      7: Draw Line <BOOL> (default: true)
 *      8: Draw same icon also at start position <BOOL> (default: false)
 *      9: Code which manitpulates text and icon before drawing.
 *          0: Souce AGL position <ARRAY>
 *          1: Mouse AGL position <ARRAY>
 *          2: Text <STRING>
 *          3: Icon image file <STRING>
 *          4: Icon color <ARRAY>
 *          5: Icon Angle <NUMBER>
 *          Code needs to return:
 *          [[_newIconPos, _newText, _newIcon, _newIconColor, _newAngle], [_startLinePos, _endLinePos, _newLineColor]]
 *
 *  Returns:
 *      None
 *
 *  Example:
 *      [player, {systemChat format ["Done %1", _this]}] call mts_zeus_fnc_getModuleDestination
 */

params [
    "_startPosASL",
    "_code",
    ["_args", [], [[]]],
    ["_text", "", [""]],
    ["_icon", "\a3\ui_f\data\IGUI\Cfg\Cursors\select_target_ca.paa", [""]],
    ["_color", [1,0,0,1], [[]]],
    ["_angle", 45, [0]],
    ["_drawLine", true, [true]],
    ["_drawIconAtStart", false, [false]],
    ["_beforeDrawingCode", {}, [{}]]
];

if (missionNamespace getVariable [QGVAR(moduleDestination_running), false]) exitWith {
    [false, _startPosASL, [0,0,0], false, false, false, _args] call _code;
    ERROR("getModuleDestination already running");
};

GVAR(moduleDestination_running) = true;

// Add mouse button eh for the zeus display (triggered from 2d or 3d)
GVAR(moduleDestination_displayEHMouse) = [findDisplay ZEUS_DISPLAY, "mouseButtonDown", {
    params ["", "_mouseButton", "", "", "_shift", "_ctrl", "_alt"];

    if (_mouseButton != 0) exitWith {}; // Only watch for LMB

    //IGNORE_PRIVATE_WARNING ["_thisArgs"]
    _thisArgs params ["_startPosASL", "_code", "_args"];

    // Get mouse position on 2D map or 3D world
    private _mousePosASL = if (ctrlShown ((findDisplay ZEUS_DISPLAY) displayCtrl ZEUS_MAP_CTRL)) then {
        private _pos2d = (((findDisplay ZEUS_DISPLAY) displayCtrl ZEUS_MAP_CTRL) ctrlMapScreenToWorld getMousePosition);
        _pos2d set [2, getTerrainHeightASL _pos2d];
        _pos2d
    } else {
        AGLToASL (screenToWorld getMousePosition);
    };
    TRACE_2("placed",_startPosASL,_mousePosASL);

    [true, _startPosASL, _mousePosASL, _shift, _ctrl, _alt, _args] call _code;
    GVAR(moduleDestination_running) = false;
}, [_startPosASL, _code, _args]] call CBA_fnc_addBISEventHandler;

// Add key eh for the zeus display (triggered from 2d or 3d)
GVAR(moduleDestination_displayEHKeyboard) = [findDisplay ZEUS_DISPLAY, "KeyDown", {
    params ["", "_keyCode", "_shift", "_ctrl", "_alt"];

    if (_keyCode != 1) exitWith {}; // Only watch for ESC

    _thisArgs params ["_startPosASL", "_code", "_args"];

    // Get mouse position on 2D map or 3D world
    private _mousePosASL = if (ctrlShown ((findDisplay ZEUS_DISPLAY) displayCtrl ZEUS_MAP_CTRL)) then {
        private _pos2d = (((findDisplay ZEUS_DISPLAY) displayCtrl ZEUS_MAP_CTRL) ctrlMapScreenToWorld getMousePosition);
        _pos2d set [2, getTerrainHeightASL _pos2d];
        _pos2d
    } else {
        AGLToASL (screenToWorld getMousePosition);
    };

    TRACE_2("aborted",_startPosASL,_mousePosASL);

    [false, _startPosASL, _mousePosASL, _shift, _ctrl, _alt, _args] call _code;
    GVAR(moduleDestination_running) = false;
    true
}, [_startPosASL, _code, _args]] call CBA_fnc_addBISEventHandler;

// Add draw EH for the zeus map - draws the 2D icon and line
GVAR(moduleDestination_mapDrawEH) = [((findDisplay ZEUS_DISPLAY) displayCtrl ZEUS_MAP_CTRL), "draw", {
    params ["_mapCtrl"];

    _thisArgs params ["_startPosASL", "_text", "_icon", "_color", "_angle", "_drawLine", "_drawIconAtStart", "_beforeDrawingCode"];

    private _pos2d = (((findDisplay ZEUS_DISPLAY) displayCtrl ZEUS_MAP_CTRL) ctrlMapScreenToWorld getMousePosition);

    private _drawingInfo = [ASLtoAGL _startPosASL, _pos2d, _text, _icon, _color, _angle, false] call _beforeDrawingCode;

    if (isNil "_drawingInfo") then {
        _drawingInfo = [];
    };

    _drawingInfo params [["_iconInfo", [], [[]]], ["_lineInfo", [], [[]]]];
    _iconInfo params [["_newPos", _pos2d, [[], objNull]], ["_newText", _text, [""]], ["_newIcon", _icon, [""]], ["_newIconColor", _color, [[]]], ["_newAngle", _angle, [0]]];
    _lineInfo params [["_startLinePos", ASLtoAGL _startPosASL, [[], objNull]], ["_endLinePos", _pos2d, [[], objNull]], ["_newLineColor", _color, [[]]]];

    _mapCtrl drawIcon [_newIcon, _newIconColor, _newPos, 24, 24, _newAngle, _newText, 1, 0.03, "TahomaB", "right"];
    if (_drawIconAtStart) then {
        _mapCtrl drawIcon [_newIcon, _newIconColor, _startLinePos, 24, 24, _newAngle];
    };

    if (_drawLine) then {
        _mapCtrl drawLine [_startLinePos, _endLinePos, _newLineColor];
    };
}, [_startPosASL, _text, _icon, _color, _angle, _drawLine, _drawIconAtStart, _beforeDrawingCode]] call CBA_fnc_addBISEventHandler;

// Add draw EH for 3D camera view - draws the 3D icon and line
[{
    (_this select 0) params ["_startPosASL", "_code", "_text", "_icon", "_color", "_angle", "_drawLine", "_drawIconAtStart", "_beforeDrawingCode"];

    if (isNull findDisplay ZEUS_DISPLAY || {!isNull findDisplay PAUSE_MENU_DISPLAY}) then {
        TRACE_3("null-exit",isNull findDisplay ZEUS_DISPLAY,isNull findDisplay PAUSE_MENU_DISPLAY);
        GVAR(moduleDestination_running) = false;
        [false, _startPosASL, [0,0,0], false, false, false, _args] call _code;
    };
    if (GVAR(moduleDestination_running)) then {
        // Draw the 3d icon and line
        private _mousePosAGL = screenToWorld getMousePosition;

        private _drawingInfo = [ASLtoAGL _startPosASL, _mousePosAGL, _text, _icon, _color, _angle, true] call _beforeDrawingCode;

        if (isNil "_drawingInfo") then {
            _drawingInfo = [];
        };

        _drawingInfo params [["_iconInfo", [], [[]]], ["_lineInfo", [], [[]]]];
        _iconInfo params [["_newPos", _mousePosAGL, [[], objNull]], ["_newText", _text, [""]], ["_newIcon", _icon, [""]], ["_newIconColor", _color, [[]]], ["_newAngle", _angle, [0]]];
        _lineInfo params [["_startLinePos", ASLtoAGL _startPosASL, [[], objNull]], ["_endLinePos", _mousePosAGL, [[], objNull]], ["_newLineColor", _color, [[]]]];

        drawIcon3D [_newIcon, _newIconColor, _newPos, 1.5, 1.5, _newAngle, _newText];
        if (_drawIconAtStart) then {
            drawIcon3D [_newIcon, _newIconColor, _startLinePos, 1.5, 1.5, _newAngle];
        };

        if (_drawLine) then {
            drawLine3D [_startLinePos, _endLinePos, _newLineColor];
        };
    } else {
        TRACE_4("cleaning up",_this select 1,GVAR(moduleDestination_displayEHMouse),GVAR(moduleDestination_displayEHKeyboard),GVAR(moduleDestination_mapDrawEH));

        (_this select 1) call CBA_fnc_removePerFrameHandler;
        (findDisplay ZEUS_DISPLAY) displayRemoveEventHandler ["mouseButtonDown", GVAR(moduleDestination_displayEHMouse)];
        (findDisplay ZEUS_DISPLAY) displayRemoveEventHandler ["KeyDown", GVAR(moduleDestination_displayEHKeyboard)];
        ((findDisplay ZEUS_DISPLAY) displayCtrl ZEUS_MAP_CTRL) ctrlRemoveEventHandler ["draw", GVAR(moduleDestination_mapDrawEH)];
        GVAR(moduleDestination_displayEHMouse) = nil;
        GVAR(moduleDestination_displayEHKeyboard) = nil;
        GVAR(moduleDestination_mapDrawEH) = nil;
    };
}, 0, [_startPosASL, _code, _text, _icon, _color, _angle, _drawLine, _drawIconAtStart, _beforeDrawingCode]] call CBA_fnc_addPerFrameHandler;
