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
    LOG("Adding 3DENComments Draw3D");
    addMissionEventHandler ["Draw3D", {
        if (!GVAR(enable3DENComments)) exitWith {
            removeMissionEventHandler [_thisEvent, _thisEventHandler];
            GVAR(3DENComments_drawEHAdded) = false;
            LOG("Removed 3DENComments Draw3D");
        };

        private _zeusDisplay = findDisplay ZEUS_DISPLAY;
        CHECK(isNull _zeusDisplay || !isNull (findDisplay PAUSE_MENU_DISPLAY));
        CHECK(ctrlShown (_zeusDisplay displayCtrl ZEUS_WATERMARK_CTRL)); // HUD Hidden

        private _camPosASL = getPosASLVisual curatorCamera;
        private _color = GVAR(3DENCommentsColor);

        {
            _x params ["_id", "_name", "_description", "_posASL"];

            private _d = _posASL distance _camPosASL;
            private _scale = linearConversion [300, 750, _d, 0.8, 0, true]; // 300m => 0.8, 750m => 0
            private _posAGL = ASLToAGL _posASL;

            if (_scale < 0.01 || {(curatorCamera worldToScreen _posAGL) isEqualTo []}) then {
                continue;
            };

            drawIcon3D [
                "a3\3den\Data\Cfg3DEN\Comment\texture_ca.paa",
                _color,
                _posAGL,
                _scale, // Width
                _scale, // Height
                0, // Angle
                _name, // Text
                1, // Shadow
                -1, // Text Size
                "RobotoCondensed" // Font
            ];

            if ((_posAGL select 2) > 0.5) then {
                drawLine3D [
                    _posAGL,
                    [_posAGL select 0, _posAGL select 1, 0],
                    _color
                ];
            };
        } count GVAR(3DENComments_data);
    }];
};

// MapDraw EH needs to be readded every time the zeus display is opened.
LOG("Adding 3DENComments map draw");
(_display displayCtrl ZEUS_MAP_CTRL) ctrlAddEventHandler ["Draw", {
    params ["_mapCtrl"];

    if (!GVAR(enable3DENComments)) exitWith {
        _mapCtrl ctrlRemoveEventHandler [_thisEvent, _thisEventHandler];
        LOG("Removed 3DENComments map draw");
    };

    CHECK(ctrlShown ((ctrlParent _mapCtrl) displayCtrl ZEUS_WATERMARK_CTRL)); // HUD Hidden

    private _color = GVAR(3DENCommentsColor);

    {
        _x params ["_id", "_name", "_description", "_posASL"];

        _mapCtrl drawIcon [
            "a3\3den\Data\Cfg3DEN\Comment\texture_ca.paa",
            _color,
            _posASL,
            24,
            24,
            0,
            _name,
            1,
            -1,
            "RobotoCondensed"
        ];
    } count GVAR(3DENComments_data);
}];

GVAR(3DENComments_drawEHAdded) = true;
