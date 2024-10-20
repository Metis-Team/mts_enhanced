#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds ability to destroy the bush infront of the player.
 *
 *  Parameter(s):
 *      None
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      call mts_cutter_fnc_addBushCutter
 *
 */

CHECK(!hasInterface);

#define SOUND_DISTANCE 30
#define SOUND_VOLUME 5
#define SOUND_DELAY_FACTOR 0.2

private _action = [
    QGVAR(bushcutter),
    LLSTRING(bushcutter_removeBush),
    QPATHTOF(data\icons\bushcutter_icon.paa),
    {
        params ["", "_player"];

        private _bush = [_player, BUSH_CUTTING_DISTANCE] call FUNC(seesBush);

        if (isNull _bush) exitWith {WARNING("No bush found. Cannot remove bush.")};

        if ((stance _player) isEqualTo "PRONE") then {
            _player playMove "AinvPpneMstpSnonWnonDnon_Putdown_AmovPpneMstpSnonWnonDnon";
        } else {
            _player playMove "AinvPknlMstpSnonWnonDnon_medic0";
        };

        private _soundDelay = GVAR(bushcutter_duration) * SOUND_DELAY_FACTOR;
        [{
            params ["_bush"];

            private _soundFile = format [QPATHTO_R(data\sounds\bush_cutting_%1.ogg), (floor random 4) + 1];

            playSound3D [_soundFile, _bush, false, getPosASL _bush, SOUND_VOLUME, 1, SOUND_DISTANCE];
        }, [_bush], _soundDelay] call CBA_fnc_waitAndExecute;

        [GVAR(bushcutter_duration), [_bush], {
            (_this select 0) params ["_bush"];

            // TODO: When Arma v2.12 releases, change to _bush setDamage [1, true, _player, _player]; (server execution)
            _bush setDamage 1;
        }, {}, LLSTRING(bushcutter_removeBush)
        ] call ace_common_fnc_progressBar;
    },
    {
        params ["", "_player"];
        ([_player, BUSH_CUTTING_DISTANCE] call FUNC(canCutBush))
    }
] call ace_interact_menu_fnc_createAction;
[(typeOf ACE_player), 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToClass;
