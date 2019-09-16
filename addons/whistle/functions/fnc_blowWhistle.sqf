#include "script_component.hpp"
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

if (QGVAR(FOX40) in ([player, false, true, true, true, false] call CBA_fnc_uniqueUnitItems) && {!GVAR(soundIsPlaying)}) then {
    GVAR(soundIsPlaying) = true;

    [player, [QGVAR(FOX40Sound), 300]] remoteExecCall ["say3D"];

    [{
        GVAR(soundIsPlaying) = false;
    }, [], 1] call CBA_fnc_waitAndExecute;
};

nil
