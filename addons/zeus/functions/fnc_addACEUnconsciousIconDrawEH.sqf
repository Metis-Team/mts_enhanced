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

// This needs to be player because we want the zeus unit not a unit that zeus currently controls (ace_player).
private _curatorModule = getAssignedCuratorLogic player;

// Only do this if zeus display is opened for the first time
if (isNil {(_curatorModule getVariable QGVAR(unconsciousPlayers))}) then {
    LOG("Init ACEUnconsciousIcon killed EH");
    _curatorModule setVariable [QGVAR(unconsciousPlayers), []];

    {
        if (_x getVariable ["ACE_isUnconscious", false]) then {
            [_x, true] call FUNC(drawACEUnconsciousIcon);
        };
    } count (call CBA_fnc_players);

    ["ace_unconscious", LINKFUNC(drawACEUnconsciousIcon)] call CBA_fnc_addEventHandler;
    [QGVAR(killed), LINKFUNC(drawACEUnconsciousIcon)] call CBA_fnc_addEventHandler;
};

if (!GVAR(ACEIcon_drawEHAdded)) then {
    LOG("Adding ACEUnconsciousIcon draw3D");
    [missionNamespace, "draw3D", {
        _thisArgs params ["_curatorModule"];

        CHECK(isNull (findDisplay ZEUS_DISPLAY) || !isNull (findDisplay PAUSE_MENU_DISPLAY));
        CHECK(ctrlShown (findDisplay ZEUS_DISPLAY displayCtrl ZEUS_WATERMARK_CTRL)); // HUD Hidden

        if (!GVAR(enableACEUnconsciousIcon)) exitWith {
            removeMissionEventHandler [_thisType, _thisId];
            GVAR(ACEIcon_drawEHAdded) = false;
        };

        private _unconsciousPlayers = _curatorModule getVariable [QGVAR(unconsciousPlayers), []];

        {
            private _unitPosAGL = _x modelToWorldVisual (_x selectionPosition "pelvis"); // Model center position
            private _camPosAGL = ASLToAGL (getPosASLVisual curatorCamera);
            private _d = _unitPosAGL distance _camPosAGL;
            private _scale = linearConversion [300, 730, _d, 1.5, 0, true]; // 300m => 1.5, 730m => 0

            if (_scale < 0.01) then {
                continue;
            };

            private _color = [0.9, 0, 0, 1];
            private _iconPosAGL = [_unitPosAGL select 0, _unitPosAGL select 1, (_unitPosAGL select 2) + 2];

            drawIcon3D [
                "z\ace\addons\zeus\ui\Icon_Module_Zeus_Unconscious_ca.paa",
                _color,
                _iconPosAGL,
                _scale, // Width
                _scale, // Height
                0, // Angle
                "", // Text
                1 // Shadow
            ];

            drawLine3D [
                [_iconPosAGL select 0, _iconPosAGL select 1, (_iconPosAGL select 2) - 0.02], // Hide line start behind icon
                _unitPosAGL,
                _color
            ];
        } count _unconsciousPlayers;
    }, [_curatorModule]] call CBA_fnc_addBISEventHandler;
};

// MapDraw EH needs to be readded every time the zeus display is opened.
LOG("Adding ACEUnconsciousIcon map draw");
[_display displayCtrl ZEUS_MAP_CTRL, "Draw", {
    params ["_mapCtrl"];
    _thisArgs params ["_curatorModule"];

    CHECK(ctrlShown ((ctrlParent _mapCtrl) displayCtrl ZEUS_WATERMARK_CTRL)); // HUD Hidden

    if (!GVAR(enableACEUnconsciousIcon)) exitWith {
        _mapCtrl ctrlRemoveEventHandler [_thisType, _thisId];
    };

    private _unconsciousPlayers = _curatorModule getVariable [QGVAR(unconsciousPlayers), []];

    {
        private _pos = getPosASLVisual _x;

        _mapCtrl drawIcon [
            "z\ace\addons\zeus\ui\Icon_Module_Zeus_Unconscious_ca.paa",
            [0.9, 0, 0, 1],
            _pos,
            30,
            30,
            0,
            "",
            1
        ];
    } count _unconsciousPlayers;
}, [_curatorModule]] call CBA_fnc_addBISEventHandler;

GVAR(ACEIcon_drawEHAdded) = true;
