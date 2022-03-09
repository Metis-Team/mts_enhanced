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
 *      [_display] call mts_enhanced_fnc_add3DENCommentsDrawEH
 *
 */

params ["_display"];

CHECK(!GVAR(enable3DENComments));

if (!GVAR(3DENComments_drawEHAdded)) then {
    LOG("Adding 3DENComments draw3D");
    [missionNamespace, "draw3D", {
        _thisArgs params ["_3denComments"];

        CHECK(isNull (findDisplay ZEUS_DISPLAY) || !isNull (findDisplay PAUSE_MENU_DISPLAY));
        CHECK(ctrlShown (findDisplay ZEUS_DISPLAY displayCtrl ZEUS_WATERMARK_CTRL)); // HUD Hidden

        if (!GVAR(enable3DENComments)) exitWith {
            removeMissionEventHandler [_thisType, _thisId];
            GVAR(3DENComments_drawEHAdded) = false;
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
            private _posAGL = ASLToAGL _posASL;

            drawIcon3D [
                "a3\3den\Data\Cfg3DEN\Comment\texture_ca.paa",
                _color,
                _posAGL,
                _scale, // Width
                _scale, // Height
                0, // Angle
                _name, // Text
                1 // Shadow
            ];

            if ((_posAGL select 2) > 0.5) then {
                drawLine3D [
                    _posAGL,
                    [_posAGL select 0, _posAGL select 1, 0],
                    _color
                ];
            }
        } count _3denComments;
    }, [GVAR(3DENComments_data)]] call CBA_fnc_addBISEventHandler;
};

// MapDraw EH needs to be readded every time the zeus display is opened.
LOG("Adding 3DENComments map draw");
[_display displayCtrl ZEUS_MAP_CTRL, "draw", {
    params ["_mapCtrl"];
    _thisArgs params ["_3denComments"];

    CHECK(ctrlShown ((ctrlParent _mapCtrl) displayCtrl ZEUS_WATERMARK_CTRL)); // HUD Hidden

    if (!GVAR(enable3DENComments)) exitWith {
        _mapCtrl ctrlRemoveEventHandler [_thisType, _thisId];
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
}, [GVAR(3DENComments_data)]] call CBA_fnc_addBISEventHandler;

GVAR(3DENComments_drawEHAdded) = true;
