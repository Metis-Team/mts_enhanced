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
#include "script_component.hpp"

private _curatorModule = getAssignedCuratorLogic player;

if (isNil {(_curatorModule getVariable QGVAR(iconIDArray))}) then {
    ["ace_unconscious", LINKFUNC(drawACEUnconsciousIcon)] call CBA_fnc_addEventHandler;
    {
        if (_x getVariable ["ACE_isUnconscious", false]) then {
            [_x, true] call FUNC(drawACEUnconsciousIcon);
        };
    } count (call CBA_fnc_players);
};
