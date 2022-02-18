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
 *      call mts_zeus_fnc_initDrawIconEH
 *
 */

private _curatorModule = getAssignedCuratorLogic player;

CHECK(!isNil {(_curatorModule getVariable QGVAR(unconsciousPlayers))});

{
    if (_x getVariable ["ACE_isUnconscious", false]) then {
        [_x, true] call FUNC(drawACEUnconsciousIcon);
    };
} count (call CBA_fnc_players);

["ace_unconscious", LINKFUNC(drawACEUnconsciousIcon)] call CBA_fnc_addEventHandler;
[QGVAR(killed), LINKFUNC(drawACEUnconsciousIcon)] call CBA_fnc_addEventHandler;

[{
    (_this select 0) params ["_curatorModule"];

    CHECK(isNull (findDisplay ZEUS_DISPLAY));

    private _unconsciousPlayers = _curatorModule getVariable [QGVAR(unconsciousPlayers), []];

    {
        private _pos = ASLToAGL (getPosASLVisual _x);
        private _camPos = ASLToAGL (getPosASLVisual curatorCamera);
        private _d = _pos distance _camPos;
        private _scale = linearConversion [300, 730, _d, 1.5, 0, true]; // 300m => 1.5, 730m => 0

        if (_scale < 0.01) then {
            continue;
        };

        drawIcon3D [
            "z\ace\addons\zeus\ui\Icon_Module_Zeus_Unconscious_ca.paa",
            [0.9, 0, 0, 1],
            [_pos select 0, _pos select 1, (_pos select 2) + 2],
            _scale, // Width
            _scale, // Height
            0, // Angle
            "", // Text
            1 // Shadow
        ];
    } count _unconsciousPlayers;
}, 0, [_curatorModule]] call CBA_fnc_addPerFrameHandler;
