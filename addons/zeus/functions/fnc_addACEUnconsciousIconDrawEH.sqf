#include "script_component.hpp"
/**
 *  Author: PhILoX, Timi007
 *
 *  Description:
 *      Adds an eventhandler on initialization of the zeus interface.
 *      The eventhandler adds an icon on unconscious players.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [_display] call mts_zeus_fnc_addACEUnconsciousIconDrawEH
 *
 */

params ["_display"];

CHECK(!GVAR(enableACEUnconsciousIcon));

if (!GVAR(ACEIcon_drawEHAdded)) then {
    LOG("Adding ACEUnconsciousIcon Draw3D");
    addMissionEventHandler ["Draw3D", {
        if (!GVAR(enableACEUnconsciousIcon)) exitWith {
            removeMissionEventHandler [_thisEvent, _thisEventHandler];
            GVAR(ACEIcon_drawEHAdded) = false;
            LOG("Removed ACEUnconsciousIcon Draw3D");
        };

        CHECK(isNull (findDisplay ZEUS_DISPLAY) || !isNull (findDisplay PAUSE_MENU_DISPLAY));
        CHECK(ctrlShown (findDisplay ZEUS_DISPLAY displayCtrl ZEUS_WATERMARK_CTRL)); // HUD Hidden

        private _unconsciousPlayers = allPlayers select {alive _x && {_x getVariable ["ACE_isUnconscious", false]}};
        private _camPosAGL = ASLToAGL (getPosASLVisual curatorCamera);

        {
            private _unitPosAGL = _x modelToWorldVisual (_x selectionPosition "pelvis"); // Model center position
            private _d = _unitPosAGL distance _camPosAGL;
            private _scale = linearConversion [300, 750, _d, 1.5, 0, true]; // 300m => 1.5, 750m => 0

            // Don't draw icon if unit is out of range or not in view of the camera
            if (_scale < 0.01 || {(curatorCamera worldToScreen _unitPosAGL) isEqualTo []}) then {
                continue;
            };

            private _iconPosAGL = _unitPosAGL vectorAdd [0, 0, 2];
            drawIcon3D [
                "z\ace\addons\zeus\ui\Icon_Module_Zeus_Unconscious_ca.paa",
                GVAR(ACEUnconsciousIconColor),
                _iconPosAGL,
                _scale, // Width
                _scale, // Height
                0, // Angle
                "", // Text
                1 // Shadow
            ];

            drawLine3D [
                _iconPosAGL vectorAdd [0, 0, -0.02], // Hide line start behind icon
                _unitPosAGL,
                GVAR(ACEUnconsciousIconColor)
            ];
        } count _unconsciousPlayers;
    }];
};

// MapDraw EH needs to be readded every time the zeus display is opened.
LOG("Adding ACEUnconsciousIcon map draw");
(_display displayCtrl ZEUS_MAP_CTRL) ctrlAddEventHandler ["Draw", {
    params ["_mapCtrl"];

    if (!GVAR(enableACEUnconsciousIcon)) exitWith {
        _mapCtrl ctrlRemoveEventHandler [_thisEvent, _thisEventHandler];
        LOG("Removed ACEUnconsciousIcon map draw");
    };

    CHECK(ctrlShown ((ctrlParent _mapCtrl) displayCtrl ZEUS_WATERMARK_CTRL)); // HUD Hidden

    private _unconsciousPlayers = allPlayers select {alive _x && {_x getVariable ["ACE_isUnconscious", false]}};

    {
        _mapCtrl drawIcon [
            "z\ace\addons\zeus\ui\Icon_Module_Zeus_Unconscious_ca.paa",
            GVAR(ACEUnconsciousIconColor),
            getPosASLVisual _x,
            30,
            30,
            0,
            "",
            1
        ];
    } count _unconsciousPlayers;
}];

GVAR(ACEIcon_drawEHAdded) = true;
