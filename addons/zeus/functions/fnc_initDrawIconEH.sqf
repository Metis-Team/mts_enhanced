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
    {
        if (_x getVariable ["ACE_isUnconscious", false]) then {
            [_x, true] call FUNC(drawACEUnconsciousIcon);
        };
    } count (call CBA_fnc_players);
    ["ace_unconscious", LINKFUNC(drawACEUnconsciousIcon)] call CBA_fnc_addEventHandler;

    // Update position if body is moved
    [{
        params ["_curatorModule"];

        private _iconIDArray = _curatorModule getVariable [QGVAR(iconIDArray), []];
        {
            _x params ["_unit", "_iconID", "_oldPos2D"];
            private _pos2D = [(getPos _unit) select 0, (getPos _unit) select 1];
            if !(_oldPos2D isEqualTo _pos2D) then {
                [_unit, false] call FUNC(drawACEUnconsciousIcon);
                [_unit, true] call FUNC(drawACEUnconsciousIcon);
            };
        } forEach _iconIDArray;
    }, 0.1, _curatorModule] call CBA_fnc_addPerFrameHandler;
};
