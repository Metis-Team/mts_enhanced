#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Shows an icon for unconscious players in the zeus interface.
 *
 *  Parameter(s):
 *      0: OBJECT - Unit.
 *      1: BOOLEAN - Is the unit unconscious?
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [_unit, true] call mts_zeus_fnc_drawACEUnconsciousIcon
 *
 */

params [["_unit", objNull, [objNull]], ["_isUnconscious", false, [false]]];
TRACE_1("params",_this);

CHECK(isNull _unit || !isPlayer _unit);

// This needs to be player because we want the zeus unit not a unit that zeus currently controls (ace_player).
private _curatorModule = getAssignedCuratorLogic player;
private _unconsciousPlayers = _curatorModule getVariable [QGVAR(unconsciousPlayers), []];
TRACE_3("Unconscious players",player,_curatorModule,_unconsciousPlayers);

if (_isUnconscious) then {
    _unconsciousPlayers pushBackUnique _unit;
} else {
    private _unitIndex = _unconsciousPlayers findIf {_x isEqualTo _unit};
    // Unit wasn't unconscious before. Unit respawned manually -> do nothing
    CHECK(_unitIndex < 0);
    _unconsciousPlayers deleteAt _unitIndex;
};

_curatorModule setVariable [QGVAR(unconsciousPlayers), _unconsciousPlayers];
