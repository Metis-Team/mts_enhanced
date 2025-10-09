#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Heal all players.
 *
 *  Parameter(s):
 *      0: STRING - Chat command arguments as string.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      call mts_chat_commands_fnc_healAll
 *
 */

{
    ["ace_medical_treatment_fullHealLocal", _x, _x] call CBA_fnc_targetEvent;
} forEach (call CBA_fnc_players);
