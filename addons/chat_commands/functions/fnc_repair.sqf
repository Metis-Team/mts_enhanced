#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Repairs a vehicle.
 *
 *  Parameter(s):
 *      0: STRING - Chat command arguments as string.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [""] call mts_chat_commands_fnc_repair
 *
 */

private _vehicle = objectParent player;

if (isNull _vehicle) then {
    cursorObject setDamage 0;
} else {
    _vehicle setDamage 0;
};
