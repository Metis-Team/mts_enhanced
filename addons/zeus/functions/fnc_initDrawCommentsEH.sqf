#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Draws 3DEN comments in zeus.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [] call mts_enhanced_fnc_initDrawCommentsEH
 *
 */

params ["_display"];

CHECK(GVAR(drawCommentEhAdded));

private _3denComments = getMissionConfigValue [QGVAR(3denComments), []];

TRACE_1("3DEN Comments", _3denComments);

[missionNamespace, "draw3D", {
    _thisArgs params ["_3denComments"];

    CHECK(isNull (findDisplay ZEUS_DISPLAY));

    if (!GVAR(enable3DENComments)) exitWith {
        removeMissionEventHandler [_thisType, _thisId];
        GVAR(drawCommentEhAdded) = false;
    };

    {
        _x params ["_id", "_name", "_description", "_posASL"];

        private _camPosASL = getPosASLVisual curatorCamera;
        private _d = _posASL distance _camPosASL;
        private _scale = linearConversion [300, 750, _d, 0.8, 0, true]; // 300m => 1.5, 730m => 0

        if (_scale < 0.01) then {
            continue;
        };

        private _color = [0.2,0.8,0.6,1];

        drawIcon3D [
            "a3\3den\Data\Cfg3DEN\Comment\texture_ca.paa",
            _color,
            ASLToAGL _posASL,
            _scale, // Width
            _scale, // Height
            0, // Angle
            _name, // Text
            1 // Shadow
        ];

        drawLine3D [
            ASLToAGL _posASL,
            [_posASL select 0, _posASL select 1, 0],
            _color
        ];
    } count _3denComments;
}, [_3denComments]] call CBA_fnc_addBISEventHandler;

[_display displayCtrl ZEUS_MAP_CTRL, "draw", {
    params ["_mapCtrl"];
    _thisArgs params ["_3denComments"];

    if (!GVAR(enable3DENComments)) exitWith {
        _mapCtrl ctrlRemoveEventHandler [_thisType, _thisId];
        GVAR(drawCommentEhAdded) = false;
    };

    {
        _x params ["_id", "_name", "_description", "_posASL"];

        private _color = [0.2,0.8,0.6,1];

        _mapCtrl drawIcon [
            "a3\3den\Data\Cfg3DEN\Comment\texture_ca.paa",
            _color,
            _posASL,
            24,
            24,
            0,
            _name,
            1
        ];
    } count _3denComments;
}, [_3denComments]] call CBA_fnc_addBISEventHandler;

GVAR(drawCommentEhAdded) = true;
