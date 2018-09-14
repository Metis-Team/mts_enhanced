/**
 *  Author: Timi007
 *
 *  Description:
 *      Plays the whistle sound if the whistle item is in the player's inventory.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      call mts_whistle_fnc_blowWhistle
 *
 */
#include "script_component.hpp"

if ("MTS_FOX40_Whistle" in (items player) && {!GVAR(soundIsPlaying)}) then {
    GVAR(soundIsPlaying) = true;

    private _isInside = false;
    if ([player] call FUNC(isInBuilding)) then {_isInside = true;};
    playSound3D ["z\mts_enhanced\addons\whistle\data\sounds\fox40_whistle_sound.ogg", player, _isInside, getPosASL player, 10, 1, 300];

    [{
        GVAR(soundIsPlaying) = false;
    }, [], 1] call CBA_fnc_waitAndExecute;
};

nil
